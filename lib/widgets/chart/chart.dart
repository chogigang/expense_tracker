import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

// 모든 지출 내역을 시각적인 차트로 보여주는 위젯입니다.
class Chart extends StatelessWidget {
  // 생성자: Chart 위젯을 만들 때 외부(expenses.dart)에서 전체 지출 목록(expenses)을 전달받습니다.
  const Chart({super.key, required this.expenses});

  // 외부에서 전달받은 모든 지출('Expense') 객체들이 담긴 리스트입니다.
  final List<Expense> expenses;

  // 'buckets'라는 이름의 getter(계산된 속성)입니다.
  // 이 getter가 호출될 때마다 카테고리별로 지출을 그룹화한 'ExpenseBucket' 리스트를 생성하여 반환합니다.
  List<ExpenseBucket> get buckets {
    return [
      // 'food' 카테고리에 해당하는 지출만 필터링해서 ExpenseBucket 객체를 생성합니다.
      ExpenseBucket.forCategory(expenses, Category.food),
      // 'leisure' 카테고리에 해당하는 지출만 필터링해서 ExpenseBucket 객체를 생성합니다.
      ExpenseBucket.forCategory(expenses, Category.leisure),
      // 'travel' 카테고리에 해당하는 지출만 필터링해서 ExpenseBucket 객체를 생성합니다.
      ExpenseBucket.forCategory(expenses, Category.travel),
      // 'work' 카테고리에 해당하는 지출만 필터링해서 ExpenseBucket 객체를 생성합니다.
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  // 'maxTotalExpense'라는 이름의 getter입니다.
  // 모든 카테고리(buckets) 중에서 가장 지출이 큰 카테고리의 총액을 찾아냅니다.
  // 이 값은 차트 막대의 최대 높이를 결정하는 기준이 됩니다.
  double get maxTotalExpense {
    double maxTotalExpense = 0; // 최대 지출액을 저장할 변수를 0으로 초기화합니다.

    // 'buckets' 리스트에 있는 각 'bucket'(카테고리별 지출 그룹)을 순회합니다.
    for (final bucket in buckets) {
      // 현재 버킷의 총 지출액이 이전에 찾은 최대 지출액보다 크다면,
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses; // 최대 지출액을 현재 버킷의 값으로 업데이트합니다.
      }
    }

    return maxTotalExpense; // 찾아낸 최대 지출액을 반환합니다.
  }

  @override
  Widget build(BuildContext context) {
    // 현재 기기가 다크 모드인지 아닌지 확인합니다.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // 차트의 전체적인 모양과 스타일을 담당하는 컨테이너 위젯입니다.
    return Container(
      margin: const EdgeInsets.all(16), // 컨테이너 바깥쪽 여백
      padding: const EdgeInsets.symmetric(
        vertical: 16, // 컨테이너 안쪽 수직(위아래) 여백
        horizontal: 8, // 컨테이너 안쪽 수평(좌우) 여백
      ),
      width: double.infinity, // 너비를 화면에 꽉 채웁니다.
      height: 180, // 높이를 180으로 고정합니다.
      decoration: BoxDecoration(
        // 컨테이너를 꾸미는 부분입니다.
        borderRadius: BorderRadius.circular(8), // 모서리를 둥글게 깎습니다.
        gradient: LinearGradient(
          // 배경에 그라데이션 효과를 줍니다.
          colors: [
            // 앱 테마의 primary 색상을 30% 투명도로 시작해서
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            // 0% 투명도(완전 투명)로 끝나도록 설정합니다.
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter, // 그라데이션 시작점 (아래쪽 중앙)
          end: Alignment.topCenter, // 그라데이션 끝나는 점 (위쪽 중앙)
        ),
      ),
      // 컨테이너 내부에 들어갈 자식 위젯들입니다.
      child: Column(
        // 자식들을 수직으로 배치합니다.
        children: [
          // 1. 차트 막대 부분
          Expanded(
            // 남은 수직 공간을 모두 차지하도록 확장합니다.
            child: Row(
              // 차트 막대들을 수평으로 배치합니다.
              crossAxisAlignment:
                  CrossAxisAlignment.end, // 막대들을 아래쪽 기준으로 정렬합니다.
              children: [
                // 'buckets' 리스트의 각 'bucket'에 대해 'ChartBar' 위젯을 하나씩 생성합니다.
                // for-in 루프를 사용하여 리스트에 위젯을 동적으로 추가하는 방식입니다.
                for (final bucket in buckets)
                  ChartBar(
                    // 각 막대의 채워질 비율(0.0 ~ 1.0)을 계산해서 전달합니다.
                    fill: bucket.totalExpenses == 0
                        ? 0 // 지출이 0원이면 나누기 오류를 피하기 위해 0을 전달합니다.
                        : bucket.totalExpenses /
                            maxTotalExpense, // (현재 카테고리 지출 / 최대 카테고리 지출)
                  )
              ],
            ),
          ),
          // 2. 차트 막대와 아이콘 사이의 간격
          const SizedBox(height: 12),
          // 3. 카테고리 아이콘 부분
          Row(
            // 'buckets' 리스트를 'map'을 사용하여 각각의 'bucket'을 아이콘 위젯으로 변환합니다.
            children: buckets
                .map(
                  (bucket) => Expanded(
                    // 각 아이콘이 동일한 너비를 갖도록 확장합니다.
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        // 'categoryIcons' 맵에서 현재 버킷의 카테고리에 맞는 아이콘을 찾아 표시합니다.
                        categoryIcons[bucket.category],
                        // 다크 모드 여부에 따라 아이콘 색상을 다르게 설정합니다.
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(), // map의 결과(Iterable)를 리스트로 변환하여 children에 전달합니다.
          )
        ],
      ),
    );
  }
}
