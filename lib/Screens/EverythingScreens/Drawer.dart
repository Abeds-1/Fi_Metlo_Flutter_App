import 'package:fimetlo/Screens/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:fimetlo/Screens/Settings.dart';
import 'package:fimetlo/Screens/ContactUs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fimetlo/Screens/EverythingScreens/PersonalPage.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer(
      {super.key,
      this.login,
      this.guest,
      this.setDefaultCurrentIndex,
      this.darkMode, this.arabic, this.notification});
  final setDefaultCurrentIndex;
  final darkMode;
  final login;
  final guest;
  final arabic;
  final notification;
  static const routeContact = '/FirstScreen';

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, Widget icon, dynamic Fun) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'POPPINS',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: Fun,
    );
  }
  void signOut() async{
     Navigator.pop(context);
     widget.login["setIsLoggedin"]();
     await FirebaseAuth.instance.signOut();
     setState(() {
       widget.login["setIsLoggedin"]();
     });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shadowColor:
            widget.darkMode["getIsDarkMode"]() ? Colors.amber : Color(0xFFC30000),
        width: 200,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 90,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              color: widget.darkMode["getIsDarkMode"]()
                  ? Colors.amber
                  : Color(0xFFC30000),
              child: const Text(
                "Fimetlo",
                style: TextStyle(
                    fontFamily: "POPPINS",
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color.fromARGB(221, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildListTile(widget.arabic["getIsArabic"]() ? "الصفحة الرئيسية" : "Home", FaIcon(FontAwesomeIcons.home), () {
              Navigator.pop(context);
              widget.setDefaultCurrentIndex();
            }),
            buildListTile(widget.arabic["getIsArabic"]()? "الإعدادات" : "Settings", Icon(Icons.settings), () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Settings(darkMode: widget.darkMode, arabic: widget.arabic, notification: widget.notification)));
            }),
            buildListTile(widget.arabic["getIsArabic"]()? "للتواصل معنا" : "Contact us", Icon(Icons.phone), () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactUs(
                            darkMode: widget.darkMode,
                          )));
            }),
            Visibility(
              visible: !widget.login["getIsLoggedin"](),
              child: buildListTile(widget.arabic["getIsArabic"]()? "تسجيل دخول" : "Login", Icon(Icons.login), () {
                Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstScreen(
                              login: widget.login, guest: widget.guest, fromWhere: "drawer", darkMode: widget.darkMode,)));
              }),
            ),
           

          ]),
        ),
      ),
    );
  }
}