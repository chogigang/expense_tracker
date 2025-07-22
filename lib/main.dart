import 'package:flutter/material.dart';
//import 'package:flutter/services.dart'; // 세로 모드를 사용을 위한 임포트
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  //세로 모드 고정
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp, // 세로 모드 고정
  // ]).then((fn) {
  //   runApp(const MyApp());
  // });

  runApp(const MyApp());
}

var KColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var KDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

/*
ThemeData.dark(
  useMaterial3: true,
  colorScheme: kColorScheme,
  cardTheme: ...
)
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        //기기의 다크모드에 따라 앱도 다크모드로 바뀜
        colorScheme: KDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: KDarkColorScheme
              .secondaryContainer, // secondaryContainer 플러터가 지정한 컬러
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          ////버튼설정
          style: ElevatedButton.styleFrom(
            backgroundColor: KDarkColorScheme.primaryContainer,
            foregroundColor: KDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: KColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: KColorScheme.onPrimaryContainer,
          foregroundColor: KColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color:
              KColorScheme.secondaryContainer, // secondaryContainer 플러터가 지정한 컬러
          margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical:
                  8), //위젯 여백    symmetric 사용시 수평 수직 설정  horizontal 수평  vertical 수직
        ),
        // 이매채는 copyWith이 없음
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: KColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold, //nomal ,bold 두껍게
                // color: Colors.red, //컬러 설정해도 배경화면에 따라 색이 안변하는 경우도 있다.
                color: KColorScheme.onSecondaryContainer,
                fontSize: 16,
              ), //타이틀 텍스트
            ),
      ),
      //themeMode: ThemeMode.system,// default
      home: const Expenses(),
    );
  }
}
