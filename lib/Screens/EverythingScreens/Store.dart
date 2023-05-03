import 'package:flutter/material.dart';
import 'package:fimetlo/Screens/EverythingScreens/PersonalPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Shop_details.dart';

class Store extends StatelessWidget {
  Store({
    super.key,
    this.darkMode,
    this.login,
    this.guest,
  });
  final darkMode;
  final login;
  final guest;

  static const routeName = '/store-page';
  int balance = 0;

  final List<Image> ListOfImages = [
    Image.asset("assets/Sanita  Coupn.png"),
    Image.asset("assets/Gandour_coupon.png"),
    Image.asset("assets/masters coupon.png"),
    Image.asset("assets/Mimosa (2).png"),
    Image.asset("assets/Ksara coupn.png"),
    Image.asset("assets/Patchi coupon.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Row(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Coupon Store",
                      style: TextStyle(fontFamily: "POPPINS", fontSize: 17),
                    ))
              ],
            ),
            SizedBox(
              height: 0,
              width: 130,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(),
                  Container(
                      padding: EdgeInsets.only(top: 30, right: 5),
                      child: Icon(
                        Icons.account_balance,
                        size: 20,
                      )),
                  Container(
                      padding: EdgeInsets.only(
                        top: 30,
                      ),
                      child: Text(
                        "${balance} points",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontFamily: "POPPINS",
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        Column(children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[0],
                                        Value: 25,
                                        item: "Sanita",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset("assets/Sanitalogo.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Sanita",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[1],
                                        Value: 25,
                                        item: "Gandour",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset("assets/gandour logo.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Gandour",
                                    style: TextStyle(
                                        fontFamily: "POPPINS",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[2],
                                        Value: 25,
                                        item: "Masters",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset("assets/images.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Masters",
                                    style: TextStyle(
                                        fontFamily: "POPPINS",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[3],
                                        Value: 25,
                                        item: "Mimosa",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset("assets/mimosa logo.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Mimosa",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[4],
                                        Value: 25,
                                        item: "Ksara",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset(
                                    "assets/Chateau_Ksara_Weingut_aus_dem_libanon.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Ksara",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 200,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetail(
                                        img: ListOfImages[5],
                                        Value: 25,
                                        item: "Patchi",
                                        darkMode: darkMode,
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.asset("assets/patchi logo.png",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 5, left: 7),
                                  child: Text(
                                    "Coupon: Patchi",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(bottom: 10, left: 7),
                                  child: Text(
                                    "25% off",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w400,
                                      color: darkMode["getIsDarkMode"]()
                                          ? Colors.amber
                                          : Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ]),
    ));
  }
}