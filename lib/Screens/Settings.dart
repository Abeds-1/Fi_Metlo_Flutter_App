import 'package:fimetlo/Screens/EverythingScreens/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:fimetlo/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


class Settings extends StatefulWidget {
  Settings({super.key, this.darkMode, this.arabic, this.notification});
  final arabic;
  final darkMode;
  final notification;
  
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
    late Size screenSize = MediaQuery.of(context).size;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return Container(
    
      height: 80,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 68, 68, 68) :Colors.white ,
                          boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                        ),
      child: SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: (value) => updateValue(value),
        inactiveThumbColor: widget.darkMode["getIsDarkMode"]() ? Colors.amber : Colors.red,
        selectedTileColor: widget.darkMode["getIsDarkMode"]() ? Colors.amber : Colors.red,
        activeColor: widget.darkMode["getIsDarkMode"]() ? Colors.amber : Colors.red,
        activeTrackColor: widget.darkMode["getIsDarkMode"]() ? Colors.amber : Colors.red,
      ),
    );
  }

Future<void> createNotification()async{
  await AwesomeNotifications().createNotification(content: NotificationContent(id: 1,
  channelKey: "basic_channel",
  title: "Hey, Jhon Doe",
  body: "You just enabled the notification!",
  actionType: ActionType.Default,
  largeIcon: 'asset://assets/FimetloLogo.png' )); 
}

Future<bool> checkNotificationPermission() async {
  return await AwesomeNotifications().isNotificationAllowed();
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.darkMode["getIsDarkMode"]() ? Colors.amber : Color(0xFFC30000),
        title: Text(
         widget.arabic["getIsArabic"]()? "الإعدادات" : "Settings",
          style: TextStyle(fontFamily: "POPPINS"),
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.arabic["getIsArabic"]()? "ضبط إعداداتك" : 'Adjust your settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'POPPINS',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
          _buildSwitchListTile(
              widget.arabic["getIsArabic"]()? "تغيير اللغة إلى العربية" : "Change language to arabic",
              widget.arabic["getIsArabic"]()? "سوف يتم تغيير جميع المكونات القابلة للقراءة إلى اللغة العربية بدلاً من الإنجليزية" : "Will switch all readable components into arabic instead of english",
              widget.arabic["getIsArabic"](), (newValue) async {
            widget.arabic["setIsArabic"]();
          }),
          _buildSwitchListTile(
              widget.arabic["getIsArabic"]()? "تفعيل جميع الإشعارات" : "Turn on all notifications",
              widget.arabic["getIsArabic"]()? "سوف يتم إيقاف جميع الإشعارات، بما في ذلك إشعارات النظام الأساسية ولكن ليس إشعارات محددة من قبل المستخدم" : "Will turn off all notifications, including core system notifications but not user set specific notifications",
              widget.notification["getIsNotification"](), (newValue) async {
              if(newValue == true){
                if(await checkNotificationPermission() == true){
                  createNotification();
                   widget.notification["setIsNotification"]();
                }else{
                  await AwesomeNotifications().requestPermissionToSendNotifications();
                   if(checkNotificationPermission() == true){
                    createNotification();
                     widget.notification["setIsNotification"]();
                }
                }
               }
              else{
                 widget.notification["setIsNotification"]();
              }
          }),
          _buildSwitchListTile(
              widget.arabic["getIsArabic"]()? "تفعيل وضع الظلام في جميع أنحاء التطبيق" : "Enable dark mode",
              widget.arabic["getIsArabic"]()? "سيتم تمكين وضع الظلام عبر كافة التطبيق" : "Will enable dark mode across the entire application",
              widget.darkMode["getIsDarkMode"](), (newValue) async {
            widget.darkMode["setIsDarkMode"]();
          }),
          Container(
              child: Image.asset("assets/Wavy Buddies - Night City.png"))
            ],
          ),
        ),
      ]),
    );
  }

  

  void toggleDarkMode(value) {}
}