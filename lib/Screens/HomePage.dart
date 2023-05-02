import 'package:fimetlo/Screens/EverythingScreens/Store.dart';
import 'package:fimetlo/main.dart';
import 'package:flutter/material.dart';
import 'package:fimetlo/From_mimi/12.1%20dummy_data.dart';
import 'package:fimetlo/From_mimi/category_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, this.darkMode, this.globalKey, this.arabic, this.login});
  final login;
  final globalKey;
  final darkMode;
  final arabic;

  //  Container(
  //           alignment: Alignment.topRight,
  //           padding: EdgeInsets.only(top: 10, right: 3, bottom: 10),
  //           child: Text(
  //             "Store",
  //             style: TextStyle(
  //                 fontFamily: ("POPPINS"),
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w700,
  //                 fontStyle: FontStyle.italic),
  //           ),
  //         ),
  //         IconButton(
  //           onPressed: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => Store(
  //                           darkMode: widget.darkMode,
  //                         )));
  //           },
  //           icon: Icon(Icons.shopping_bag),
  //         ),

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int _currentImageIndex = 1;
  late Size screenSize = MediaQuery.of(context).size;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _imageUrls = [
  'https://via.placeholder.com/300/00001c/FFFFFF',
  'https://via.placeholder.com/300/00001c/FFFFFF',
  'https://via.placeholder.com/300/00001c/FFFFFF',
];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        // height: screenSize.height,
        // width: screenSize.width,
        //alignment: Alignment.center,
        children: [
          Container(height: screenSize.height,),
         
    
              
              Positioned(
                top: 300/ 732 * screenSize.height,
                child: Container(
                  decoration: BoxDecoration(
                     color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) : Color.fromARGB(255, 231, 231, 231),
                   
                  ),
                 
                  height: 340/ 732 * screenSize.height,
                  width: screenSize.width,
                  child: SingleChildScrollView(
               
                     child: Column(
                       children: [
                        SizedBox(
                          height: 50,
                        ),
                         Container(
                          alignment: widget.arabic["getIsArabic"]()? Alignment.centerRight : Alignment.centerLeft,
                              width: screenSize.width,
                              
                              margin: EdgeInsets.fromLTRB(10 / 412 * screenSize.width, 10 / 732 * screenSize.height, 10 / 412 * screenSize.width, 0),
                              child: Text(widget.arabic["getIsArabic"]()? "منتجات مميزة" : "Featured Products", style: TextStyle(color: widget.darkMode["getIsDarkMode"]() ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
                              SizedBox(height:  20/ 732 * screenSize.height,),
                         CarouselSlider(
                             items: _imageUrls.map((image) {
                               return Container(
                                
                                 margin: EdgeInsets.symmetric(horizontal: 10),
                                 decoration: BoxDecoration(
                                  
                                   borderRadius: BorderRadius.all(Radius.circular(20)),
                                   image: DecorationImage(
                                     image: NetworkImage(image),
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               );
                             }).toList(),
                             options: CarouselOptions(
                               initialPage: 1,
                               enableInfiniteScroll: false,
                               height: 150,
                              // enlargeCenterPage: true,
                               autoPlay: false,
                               onPageChanged: (index, _) {
                                 setState(() {
                                   _currentImageIndex = index;
                                 });
                               },
                             ),
                           ),
                           SizedBox(height: 20,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: _imageUrls.asMap().entries.map((entry) {
                               int index = entry.key;
                               return Container(
                                 width: 8,
                                 height: 8,
                                 margin: EdgeInsets.symmetric(horizontal: 4),
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: _currentImageIndex == index
                                       ? Colors.blue
                                       : Colors.grey[400],
                                 ),
                               );
                             }).toList(),
                           ),
                            SizedBox(height: 20/ 732 * screenSize.height,),
                            Container(
                              alignment: widget.arabic["getIsArabic"]()? Alignment.centerRight : Alignment.centerLeft,
                              width: screenSize.width,
                              margin: EdgeInsets.fromLTRB(10 / 412 * screenSize.width, 10 / 732 * screenSize.height, 10 / 732 * screenSize.height, 0),
                              child: Text(widget.arabic["getIsArabic"]()? "التصنيفات" : "Categories", style: TextStyle(color: widget.darkMode["getIsDarkMode"]() ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
                              SizedBox(height:  20/ 732 * screenSize.height,),
                              Container(
                              

                                         height: 135,
                                               child: SingleChildScrollView(
                                                reverse: widget.arabic["getIsArabic"](),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                          textDirection: widget.arabic["getIsArabic"]()? TextDirection.rtl : TextDirection.ltr,
                            children:  [SizedBox(width: 10 / 412 * screenSize.width,) ,...DUMMY_CATEGORIES
                                  .map(
                                    (catData) => CategoryItem(
                                      catData.id,
                                      catData.title,
                                      widget.darkMode["getIsDarkMode"]() ? Color(0xFF00001c) : catData.color,
                                      widget.darkMode["getIsDarkMode"]() ? Colors.white : Colors.black
                                    ),
                                  )
                                  .toList()]),
                                               ),
                              ),
                              SizedBox(height: 20/ 732 * screenSize.height,),
                       ],
                     ),
                   ),
                ),
              ), 




               Container(
             
             decoration: BoxDecoration(
               boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(23), bottomRight: Radius.circular(23)),
              color:  widget.darkMode["getIsDarkMode"]() ? Color(0xFFF6BE00) : Color(0xFFC30000),    
    image: DecorationImage(
      image: AssetImage('assets/iPhone 14 - 1 (3).png'),
      fit: BoxFit.cover,
    ),
  ),
         
          height: 330/ 732 * screenSize.height,
          width: screenSize.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[ 
                SizedBox(
                  height: 10 / 732 * screenSize.height,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     IconButton(
          color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) : Colors.white,
          onPressed: () {
            widget.globalKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu)),
                    SizedBox(
                      width: 135 / 412 * screenSize.width,
                    ),
                    // Container(
                    //   width:60,
                    //   height: 60,
                    //   decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/fimetlowhite.png'), fit: BoxFit.cover,)),
                    // ),
                    SizedBox(
                      width: 175 / 412 * screenSize.width,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.circle_notifications_rounded,
                        size: 45,
                        color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) :Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7 / 732 * screenSize.height,
                ),
                Row(
                  textDirection: widget.arabic["getIsArabic"]()? TextDirection.rtl : TextDirection.ltr,
                  children: [
                    SizedBox(width: 10,),
                    Container(
                          width: 70 / 412 * screenSize.width,
                          height: 70 / 732 * screenSize.height,
                          decoration: BoxDecoration(
                             boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 4.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                            border: Border.all(width: 2, color: Colors.white),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    "https://pbs.twimg.com/media/DZotU1hW0AEDN5F.jpg:large"),
                              )),
                        ),
                        SizedBox(
                          width: 10 / 412 * screenSize.width,
                        ),
                        Column(
                          crossAxisAlignment: widget.arabic["getIsArabic"]()? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.arabic["getIsArabic"]()? "جاك ضو" : "Jack Doe",
                              style: TextStyle(
                                 fontFamily: "PlayfairDisplay-VariableFont_wght",
                                color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) :Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Row(
                              textDirection: widget.arabic["getIsArabic"]()? TextDirection.rtl : TextDirection.ltr,
                              children: [FaIcon(FontAwesomeIcons.houseUser, color: Colors.white,), SizedBox(width: 10,), 
                            Text(widget.arabic["getIsArabic"]()? "jack@hotmail.com :البريد" : "Email: jack@hotmail.com", style: TextStyle(color: Colors.white),),], 
                      
                            ),
                           
                          ],
                        ),
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    
                    width: 300,
                      decoration: BoxDecoration(
                         boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5), // Set the shadow color
        spreadRadius: 2, // Set the spread radius of the shadow
        blurRadius: 9, // Set the blur radius of the shadow
        //offset: Offset(0, 3), // Set the offset of the shadow
      ),
    ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withOpacity(0.9),
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
                  '5',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                                  ),
                                  SizedBox(width: 2,), 
                                  Icon(Icons.star, color: Colors.black,)
                                ],
                              ),
                              SizedBox(
                  height: 5,
                              ),
                              Text(
                  widget.arabic["getIsArabic"]()? "نقاط" :'Points',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              Text(
                  '100',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                              ),
                              SizedBox(
                  height: 5,
                              ),
                              Text(
                  widget.arabic["getIsArabic"]()? "كوبونات" : 'Coupons',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ),
      Container(height: 15 / 732 * screenSize.height,),
                          Row(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(16 / 412 * screenSize.width, 8 / 732 * screenSize.height, 10 / 412 * screenSize.width, 8 / 732 * screenSize.height),
                                    width: 340 / 412 * screenSize.width,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 207, 207, 207),
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 4.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ThemeData().colorScheme.copyWith(
                                          primary: Colors.black,
                                        ),
                                  ),
                                  child: TextFormField(
                                    onTapOutside: (e) {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(13, 13, 0, 0),
                                      hintText: widget.arabic["getIsArabic"]()? "ابحث هنا" : 'Search here...',
                                      hintStyle: TextStyle(color: Color.fromARGB(255, 37, 37, 37)),
                                      border: InputBorder.none,
                                      suffixIcon: Icon(
                                        Icons.search,
                                        color: Color.fromARGB(255, 69, 50, 50),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Store(darkMode: widget.darkMode, login: widget.login)));},
                                child: Icon(
                                  Icons.store,
                                  size: 35,
                                  color: widget.darkMode["getIsDarkMode"]() ? Color.fromARGB(255, 37, 37, 37) : Colors.white,
                                ),
                              ),
                            ],
                          ),
        ]),
        ),
            ]),
      );
  }
}

