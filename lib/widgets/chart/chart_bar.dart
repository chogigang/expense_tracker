import 'package:flutter/material.dart';

// 차트의 개별 막대 하나를 나타내는 위젯입니다.
class ChartBar extends StatelessWidget {
  // 생성자: 외부(Chart 위젯)에서 fill 값을 필수로 전달받습니다.
  const ChartBar({
    super.key,
    required this.fill,
  });

  // 막대가 채워질 비율(0.0 ~ 1.0)을 나타내는 값입니다.
  // 이 값이 1.0이면 막대가 꽉 차고, 0.5면 절반만 채워집니다.
  final double fill;

  @override
  Widget build(BuildContext context) {
    // 현재 기기가 다크 모드인지 아닌지 확인합니다.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Expanded 위젯은 Row나 Column의 자식으로 사용될 때,
    // 남은 공간을 다른 Expanded 위젯들과 동일한 비율로 나누어 차지합니다.
    // 여기서는 모든 막대가 동일한 너비를 갖도록 만듭니다.
    return Expanded(
      child: Padding(
        // 막대 좌우에 4만큼의 여백을 줍니다.
        padding: const EdgeInsets.symmetric(horizontal: 4),
        // 부모 위젯(Expanded)의 크기에 비례해서 자식 위젯의 크기를 조절합니다.
        child: FractionallySizedBox(
          // 높이를 부모 높이의 'fill' 비율만큼만 차지하도록 설정합니다.
          // fill 값이 0.7이면 부모 높이의 70%를 차지하는 막대가 됩니다.
          heightFactor: fill,
          // 실제 색상이 칠해지는 막대 본체입니다.
          child: DecoratedBox(
            // 막대의 모양과 색상을 꾸미는 부분입니다.
            decoration: BoxDecoration(
              // 모양을 사각형으로 지정합니다.
              shape: BoxShape.rectangle,
              // 위쪽 모서리만 둥글게 깎습니다.
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              // 다크 모드 여부에 따라 막대의 색상을 다르게 설정합니다.
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
