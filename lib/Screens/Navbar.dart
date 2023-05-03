import 'package:fimetlo/Screens/EverythingScreens/Drawer.dart';
import 'package:fimetlo/main.dart';
import 'package:flutter/material.dart';
import'package:fimetlo/Screens/HomePage.dart';
import 'package:fimetlo/Screens/FavoritesPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fimetlo/Screens/EverythingScreens/PersonalPage.dart';
import 'package:fimetlo/Screens/FirstScreen.dart';
import 'package:fimetlo/meal.dart';


class EverythingPage extends StatefulWidget {
  final login;
  final guest;
  final darkMode;
  final arabic;
  final notification;
  final List<Meal> favoriteMeals;
  const EverythingPage({super.key, required this.title, this.login, this.guest, this.darkMode, this.arabic, this.notification, required this.favoriteMeals});
  final String title;
  @override
  State<EverythingPage> createState() => _EverythingPageState();
}

class _EverythingPageState extends State<EverythingPage> {
  int currentIndex = 0;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late final pages = [HomePage(globalKey: _globalKey, darkMode: widget.darkMode, arabic: widget.arabic, login:widget.login, guest: widget.guest), FavoritesPage(widget.favoriteMeals, widget.darkMode), PersonalPage(
                              darkMode: widget.darkMode,
                              login: widget.login,
                              guest: widget.guest,
                            )];
  final primaryColor = Color(0xFFC30000);
  final secondaryColor = Color(0xFF717171);
  late Size screenSize = MediaQuery.of(context).size;

  void setDefaultCurrentIndex(){
    setState(() {
      currentIndex = 0;
    });
  }
  void setIndex(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) : Colors.white,

      appBar: currentIndex != 0  && currentIndex != 2? AppBar(
          backgroundColor: primaryColor,
         
        // title: Text(
        //   "Explore fimetlon products",
        //   style: TextStyle(fontFamily: "POPPINS"),
        // ),
        
      ) : null,
      
      
      
      drawer: MainDrawer(login: widget.login, setDefaultCurrentIndex: setDefaultCurrentIndex, guest: widget.guest, darkMode: widget.darkMode, arabic: widget.arabic, notification: widget.notification),
      
    
      body: currentIndex == 0 ? HomePage(globalKey: _globalKey, darkMode: widget.darkMode, arabic: widget.arabic, guest: widget.guest, login: widget.login) : pages[currentIndex],
      
      
      bottomNavigationBar: ClipRRect(
        //  borderRadius: BorderRadius.only(
        // topLeft: Radius.circular(30.0),
        // topRight: Radius.circular(30.0),
        //   ), 
        child: Container(
          height: 64,
          decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        // topLeft: Radius.circular(30.0),
        // topRight: Radius.circular(30.0),
        //   ), 
           color:widget.darkMode["getIsDarkMode"]() ? Color(0xFF00001c) : Colors.black,
          ),
          child: BottomNavigationBar(
            backgroundColor: widget.darkMode["getIsDarkMode"]() ? Color(0xFF00001c) : Colors.black,
            currentIndex: this.currentIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor:widget.darkMode["getIsDarkMode"]() ? Colors.amber : Colors.red,
            iconSize: 30,
            onTap: (index) {
               if(index == 2){
              if (!widget.login["getIsLoggedin"]()) {
                 
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            login: widget.login, guest: widget.guest, fromWhere: "personalPage", darkMode: widget.darkMode, setIndex: setIndex,)));
                            return;
              } 
               }
              setState(
                (){
                  
                  currentIndex = index;
                 
                }
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.house_siding_outlined,
                size: widget.arabic["getIsArabic"]()? 20 : 34,
                ),
                label: widget.arabic["getIsArabic"]()? "الصفحة الرئيسية" : "Home",
                
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.star,size: widget.arabic["getIsArabic"]()? 20 : 31,
                ),
                label:widget.arabic["getIsArabic"]()? "المفضلة" : "Favorites",
              ),
               BottomNavigationBarItem(
                icon: FaIcon(Icons.person,size: widget.arabic["getIsArabic"]()? 20 : 31,
                ),
                label:widget.arabic["getIsArabic"]()? "حسابي" : "My Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
