import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fimetlo/Screens/EverythingScreens/Store.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail(
      {super.key,
      required this.img,
      required this.Value,
      required this.item,
      this.darkMode});

  final Image img;
  final int Value;
  final String item;
  final darkMode;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double boxHeight = screenHeight / 2;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - boxHeight + 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(-50),
                          bottomRight: Radius.circular(-50)),
                      image: DecorationImage(
                        image: img.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.chevronLeft,
                              color: Colors.black,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              darkMode["getIsDarkMode"]()
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Store(
                                                darkMode: darkMode,
                                              )))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Store(
                                                darkMode: darkMode,
                                              )));
                            },
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 12),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${item}",
                              style: TextStyle(
                                  fontFamily: "POPPINS",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 379,
                  child: Container(
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 50, top: 20, bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "What\'s inside:",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 50, bottom: 3, right: 50),
                        child: Text(
                          "A limited time 25% cashback on all ${item} products you buy from the app",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 50, top: 20, bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "How to redeem:",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 50, bottom: 10, right: 50),
                        child: Text(
                          "-Simply press on the button to redeem your coupon, if you have enough points, navigate back to the items page and enjoy your discount",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: screenWidth -20,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await confirm(
                              context,
                              title: const Text(
                                'Confirm Coupon',
                                style: TextStyle(
                                    fontFamily: "POPPINS",
                                    fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                "Do you want to buy this coupon?",
                                style: TextStyle(
                                    fontFamily: "POPPINS",
                                    fontWeight: FontWeight.w200),
                              ),
                              textOK: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              textCancel: const Text(
                                'No',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )) {
                              return print('pressedOK');
                            }
                            return print('pressedCancel');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_basket, color: Colors.white),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Claim coupon",
                                  style: TextStyle(
                                    fontFamily: "POPPINS",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    height: boxHeight - 50,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: darkMode["getIsDarkMode"]()
                          ? Color.fromARGB(255, 63, 63, 63)
                          : Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.0, -5.0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}