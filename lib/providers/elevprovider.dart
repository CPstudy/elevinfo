import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:elevinfo/essential.dart';

class ThemeProvider with ChangeNotifier {


  ThemeData _themeData;

  ThemeProvider() {
    startUp();
  }

  ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
        },
      ),
      primaryColor: SColors.blueGreen,
      accentColor: SColors.colorPrimary,
      scaffoldBackgroundColor: SColors.blueGreen,
      canvasColor: SColors.gridBackgroundLight,
      cardColor: SColors.listBackgroundLight,
      textTheme: ThemeData.light().textTheme.copyWith(
        headline5: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
        headline4: TextStyle(
          color: SColors.blueGreen,
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
        headline3: TextStyle(
          color: SColors.red,
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
      ),
      dividerColor: SColors.dividerLight,
      colorScheme: ColorScheme.light().copyWith(
        primary: Colors.white.withOpacity(0.8),
        error: SColors.errorLight
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
        },
      ),
      primaryColor: SColors.colorDarkPrimary,
      accentColor: Colors.white,
      scaffoldBackgroundColor: Color(0xff19191e),
      canvasColor: SColors.gridBackgroundDark,
      cardColor: SColors.listBackgroundDark,
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline5: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
        headline4: TextStyle(
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
        headline3: TextStyle(
          color: SColors.red,
          fontFamily: 'NanumSquare',
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
      ),
      dividerColor: SColors.dividerDark,
      colorScheme: ColorScheme.light().copyWith(
        primary: SColors.colorPrimary,
        error: SColors.errorDark
      ),
    );
  }

  void startUp() async {
    Config().getTheme();
    setTheme(Config().type);
  }

  ThemeData getTheme() {
    return _themeData ?? getLightTheme();
  }

  setTheme(String type) {
    if(type == LIGHT_MODE) {
      _themeData = getLightTheme();
    } else if (type == DARK_MODE) {
      _themeData = getDarkTheme();
    } else {
      _themeData = getLightTheme();
    }

    Config().setTheme(type).then((value){
      notifyListeners();
    });

  }
}