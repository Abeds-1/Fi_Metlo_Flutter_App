import 'package:fimetlo/Screens/EverythingScreens/Drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fimetlo/Screens/HomePage.dart';
import 'package:fimetlo/From_mimi/category_meals_screen.dart';
import 'package:fimetlo/meal.dart';
import 'package:fimetlo/From_mimi/meal_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fimetlo/Screens/Navbar.dart';
import 'package:fimetlo/Screens/Navbar.dart';
import 'package:fimetlo/Screens/FirstScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'From_mimi/12.1 dummy_data.dart';
import 'package:fimetlo/Screens/FavoritesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fimetlo/Screens/Greeting.dart';

bool isArabic = false;
bool isDarkMode = false;
bool isNotification = false;
bool isFirstTime = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
      channelShowBadge: true,
    )
  ]);
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then((value) {
    isDarkMode = value.getBool("isDarkMode") ?? false;
    isArabic = value.getBool("isArabic") ?? false;
    isNotification = value.getBool("isNotification") ?? false;
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<_MyAppState> rootKey = GlobalKey<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isGuest = false;
  bool isLoggedin = FirebaseAuth.instance.currentUser != null;
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  late Map<String, dynamic> darkMode = {
    "setIsDarkMode": setIsDarkMode,
    "getIsDarkMode": getIsDarkMode,
  };

  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.light,
  );

  ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
  );
  void setIsDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool newValue = true;
      if (prefs.getBool("isDarkMode") != null) {
        newValue = !prefs.getBool("isDarkMode")!;
      }
      prefs.setBool("isDarkMode", newValue);
      isDarkMode = newValue;
    });
  }

  bool getIsDarkMode() {
    return isDarkMode;
  }

  void setIsArabic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool newValue = true;
      if (prefs.getBool("isArabic") != null) {
        newValue = !prefs.getBool("isArabic")!;
      }
      prefs.setBool("isArabic", newValue);
      isArabic = newValue;
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  bool getIsArabic() {
    return isArabic;
  }

  void setIsNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool newValue = true;
      if (prefs.getBool("isNotification") != null) {
        newValue = !prefs.getBool("isNotification")!;
      }
      ;
      prefs.setBool("isNotification", newValue);
      isNotification = newValue;
    });
  }

  late var getIsNotification = () {
    return isNotification;
  };

  late var setIsLoggedin = () {
    setState(() {
      isLoggedin = FirebaseAuth.instance.currentUser != null;
    });
  };
  late var getIsLoggedin = () {
    return isLoggedin;
  };
  late Map<String, dynamic> login = {
    "setIsLoggedin": setIsLoggedin,
    "getIsLoggedin": getIsLoggedin,
  };

  late Map<String, dynamic> arabic = {
    "setIsArabic": setIsArabic,
    "getIsArabic": getIsArabic,
  };

  late Map<String, dynamic> notification = {
    "setIsNotification": setIsNotification,
    "getIsNotification": getIsNotification,
  };

  late var setIsGuest = (bool isGuest) {
    setState(() {
      this.isGuest = isGuest;
    });
  };
  late var getIsGuest = () {
    return isGuest;
  };
  late Map<String, dynamic> guest = {
    "setIsGuest": setIsGuest,
    "getIsGuest": getIsGuest,
  };

  void setFirstTime() {
    setState(() {
      isFirstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: isDarkMode ? _darkTheme : _lightTheme,
      home: isFirstTime
          ? Greeting(setFirstTime: setFirstTime)
          : isLoggedin || isGuest
              ? EverythingPage(
                  title: 'Fimtelo',
                  login: login,
                  guest: guest,
                  darkMode: darkMode,
                  arabic: arabic,
                  notification: notification,
                  favoriteMeals: [],
                )
              : FirstScreen(
                  login: login,
                  guest: guest,
                  fromWhere: "main",
                  darkMode: darkMode,
                ),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals, darkMode),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite, darkMode),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}