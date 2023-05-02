import 'package:fimetlo/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:fimetlo/Screens/EverythingScreens/Store.dart';
import 'package:fimetlo/Screens/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({
    super.key,
    this.darkMode,
    this.login,
    this.guest,
  });

  final darkMode;
  final login;
  final guest;
  @override
  State<PersonalPage> createState() => _PersonalPage();
}

class _PersonalPage extends State<PersonalPage> {
  int balance = 0;
  int couponBought = 0;
  late Size screenSize = MediaQuery.of(context).size;
void signOut() async{
     await FirebaseAuth.instance.signOut();
     setState(() {
       widget.login["setIsLoggedin"]();
       widget.guest["setIsGuest"](false);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
                "Personal Page",
                style: TextStyle(
                    fontFamily: "POPPINS",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                    ),
              ),
        ),
        elevation: 0,
        backgroundColor:  widget.darkMode["getIsDarkMode"]()? Color(0xFFF6BE00) : Color(0xFFC30000),
        
      ),
      body: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: screenSize.height,
            width: screenSize.width,
            ),
            Container(width: screenSize.width,
            height: 220,
            color: widget.darkMode["getIsDarkMode"]()? Color(0xFFF6BE00) : Color(0xFFC30000),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Column(
                children: [
                  Container(
                                width: 100 / 412 * screenSize.width,
                                height: 100 / 732 * screenSize.height,
                                decoration: BoxDecoration(
                                   boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            blurRadius: 4.0,
                                            spreadRadius: 4.0,
                                          ),
                                        ],
                                  border: Border.all(width: 4, color: Colors.white),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          "https://pbs.twimg.com/media/DZotU1hW0AEDN5F.jpg:large"),
                                    )),
                              ),
                              SizedBox(height: 7,),
                      Text(
                               "Jack Doe",
                              style: TextStyle(
                                 fontFamily: "PlayfairDisplay-VariableFont_wght",
                                color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) :Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ), 
                            SizedBox(
                              height: 10,
                            ) , 
                             Row(
                             
                              children: [FaIcon(FontAwesomeIcons.houseUser, color: Colors.white,), SizedBox(width: 10,), 
                            Text("Email: jack@hotmail.com", style: TextStyle(color: Colors.white),),], 
                      
                            ),   
                              SizedBox(
                              height: 10,
                            ) ,  
                             Container(
                    
                    width: 350,
                      decoration: BoxDecoration(
                         boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5), // Set the shadow color
        spreadRadius: 2, // Set the spread radius of the shadow
        blurRadius: 9, // Set the blur radius of the shadow
        //offset: Offset(0, 3), // Set the offset of the shadow
      ),
    ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                   Text(
                 'Points',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                              ),
                            
                                 
                                ],
                              ),
                              SizedBox(
                  height: 5,
                              ),
                                    Text(
                  '5',
                  style: TextStyle(
                    color: widget.darkMode["getIsDarkMode"]() ? Color(0xFFF6BE00) : Color(0xFFC30000),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                                  ),
                             
                            ],
                          ),
                          // Container(
                          //   height: 30,
                          //   width: 1,
                            
                          // ),
                          Column(
                            children: [
                             Text(
                  'Coupons',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                              ),
                              SizedBox(
                  height: 5,
                              ),
                               Text(
                  '100',
                  style: TextStyle(
                    color: widget.darkMode["getIsDarkMode"]() ? Color(0xFFF6BE00) : Color(0xFFC30000),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                              ),
                              
                            ],
                          ),
                          Column(
                            children: [
                             Text(
                  'Items',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                              ),
                              SizedBox(
                  height: 5,
                              ),
                               Text(
                  '75',
                  style: TextStyle(
                    color: widget.darkMode["getIsDarkMode"]() ? Color(0xFFF6BE00) : Color(0xFFC30000),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ) ,
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Store(
                                darkMode: widget.darkMode,
                              )));
                },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: screenSize.width - 20,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 68, 68, 68) :Colors.white ,
                          boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                        ),
                                  
                                    child: Row(
                                      children: [
                      Icon(Icons.shopping_basket, color: widget.darkMode["getIsDarkMode"]() ?Colors.white : Color.fromARGB(255, 37, 37, 37)),
                      SizedBox(width: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Access the store",
                          style: TextStyle(
                            fontFamily: "POPPINS",
                            color: widget.darkMode["getIsDarkMode"]() ?Colors.white : Color.fromARGB(255, 37, 37, 37),
                          ),
                        ),
                      ),
                      SizedBox(width: 170,),
                      Icon(Icons.arrow_circle_right_rounded, size: 35, color: Colors.grey,)
                                      ],
                                    ),
                                    // style: ElevatedButton.styleFrom(
                                    //   backgroundColor: widget.darkMode["getIsDarkMode"]()
                                    //       ? Colors.amber
                                    //       : Color(0xFFC30000),
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(100),
                                    //   ),
                                  //  ),
                                  ),
                    ),


SizedBox(height: 15,),

              GestureDetector(
                      onTap: () {
                  
                 signOut();
               
                 
              
                },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: screenSize.width - 20,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 68, 68, 68) :Colors.white,
                          boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                        ),
                                  
                                    child: Row(
                                      children: [
                     Icon(Icons.logout, color: widget.darkMode["getIsDarkMode"]() ?Colors.white : Color.fromARGB(255, 37, 37, 37)),
                      SizedBox(width: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Logout" ,
                          style: TextStyle(
                            fontFamily: "POPPINS",
                            color: widget.darkMode["getIsDarkMode"]() ?Colors.white : Color.fromARGB(255, 37, 37, 37),
                          ),
                        ),
                      ),
                      SizedBox(width: 238,),
                      Icon(Icons.arrow_circle_right_rounded, size: 35, color: Colors.grey,)
                                      ],
                                    ),
                                    // style: ElevatedButton.styleFrom(
                                    //   backgroundColor: widget.darkMode["getIsDarkMode"]()
                                    //       ? Colors.amber
                                    //       : Color(0xFFC30000),
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(100),
                                    //   ),
                                  //  ),
                                  ),
                    ),
                ],
              ),
            ),
          ]),
    );
  }
}