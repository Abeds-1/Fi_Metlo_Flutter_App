import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../meal.dart';
import '12.1 dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function checkIfFavorite;
  double points;
  double values;
  final darkMode;

  MealDetailScreen(
    this.toggleFavorite,
    this.checkIfFavorite,
    this.darkMode,
    this.points,
    this.values,
  );

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  List<Meal> _favoriteMeals = [];

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: Theme.of(context).textTheme.headline6));
  }

  Widget buildContainer(Widget childish) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        height: 200,
        width: 300,
        child: childish);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    void getSelectedPref() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool isFavorite = pref.getBool(selectedMeal.id) ?? false;

      setState(() {
        widget.toggleFavorite(isFavorite);
      });
    }

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
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight - boxHeight + 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(-50),
                              bottomRight: Radius.circular(-50)),
                          image: DecorationImage(
                            image: Image.network(selectedMeal.imageUrl).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
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
                                    },
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 12),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${selectedMeal.title}",
                                      style: TextStyle(
                                          fontFamily: "POPPINS",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 230,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 3),
                                child: FloatingActionButton(
                                
                                  elevation: 5,
                                  backgroundColor: widget.darkMode["getIsDarkMode"]()
                                          ? Color(0xFFF6BE00)
                                          : Color(0xFFC30000),
                                  
                                  child: Icon(
                                    widget.checkIfFavorite(mealId)
                                        ? Icons.star
                                        : Icons.star_border,
                                  ),
                                  onPressed: () => widget.toggleFavorite(mealId),
                                  foregroundColor:
                                     Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 379,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 50, top: 20, bottom: 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "About this item:",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 0, right: 0, left: 50),
                        child: Text(
                          "${selectedMeal.Description}",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 50, top: 20, bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Rate the item:",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 50, bottom: 10, right: 50),
                        child: Text(
                          "-Rating this item will help users identify which items serve as better alternatives than other items.",
                          style: TextStyle(
                              fontFamily: "POPPINS",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Center(
                        child: Container(
                            height: 40,
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glowColor: widget.darkMode["getIsDarkMode"]()
                                  ? Color(0xFFF6BE00)
                                  : Color(0xFFC30000),
                              glowRadius: 1,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: widget.darkMode["getIsDarkMode"]()
                                    ? Color(0xFFF6BE00)
                                    : Color(0xFFC30000),
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {

                                  
                                });
                                
                              },
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Container(
                          width: screenWidth - 20,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (await confirm(
                                context,
                                title: const Text(
                                  'Confirm Payment',
                                  style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Do you want to buy this payment?",
                                  style: TextStyle(
                                      fontFamily: "POPPINS",
                                      fontWeight: FontWeight.w200),
                                ),
                                textOK: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.values += 1;
                                      widget.points += 10;
                                    });
                                  },
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
                                    "Buy Item",
                                    style: TextStyle(
                                      fontFamily: "POPPINS",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    height: boxHeight - 50,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: widget.darkMode["getIsDarkMode"]()
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