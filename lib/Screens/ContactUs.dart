import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key, this.darkMode});
  final darkMode;

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

// ···
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Us",
            style: TextStyle(fontFamily: "POPPINS"),
          ),
          backgroundColor:
              darkMode["getIsDarkMode"]() ? Colors.amber : Color(0xFFC30000),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 250,
                height: 360,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 5,
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Container(
                            height: 125,
                            child: Image.asset("assets/Hands.png")),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Contact us using:",
                              style: TextStyle(
                                  fontFamily: "POPPINS",
                                  color: darkMode["getIsDarkMode"]()? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () => launchUrl(emailLaunchUri),
                              child: Row(
                                children: [
                                  Icon(Icons.email),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkMode["getIsDarkMode"]()
                                    ? Colors.amber
                                    : Color(0xFFC30000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.only(bottom: 10),
                            width: 135,
                            child: ElevatedButton(
                              onPressed: () => launch("tel://"),
                              child: Row(
                                children: [
                                  Icon(Icons.mobile_friendly),
                                  Text(
                                    "Telephone",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkMode["getIsDarkMode"]()
                                    ? Colors.amber
                                    : Color(0xFFC30000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            )),
                        Container(
                            width: 145,
                            child: ElevatedButton(
                              onPressed: () async {
                                final String url = 'sms:';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.message),
                                  Text(
                                    "Message Us",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkMode["getIsDarkMode"]()
                                    ? Colors.amber
                                    : Color(0xFFC30000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            )),
                      ])),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Copyright © 2023 Fimetlo Inc. All rights reserved.",
                style: TextStyle(
                  fontFamily: "POPPINS",
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 35, top: 5),
              child: Text(
                "This message signifies that all content, trademarks, and intellectual property owned by Fimetlo Inc. are protected under applicable laws and regulations. Unauthorized use or reproduction of any materials owned by Fimetlo Inc. is strictly prohibited and may result in legal action. Fimetlo Inc. reserves the right to modify or update this copyright message at any time without prior notice.",
                style: TextStyle(
                  fontFamily: "POPPINS",
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ));
  }
}