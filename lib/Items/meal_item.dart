import 'dart:ffi';

import 'package:fimetlo/From_mimi/meal_detail_screen.dart';

import '../meal.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final int Price;
  final double rating;
  final Availability availability;

  final darkMode;
  const MealItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      this.darkMode,
      required this.rating,
      required this.Price,
      required this.availability});

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((result) {
      if (result != null) {}
    });
  }

  String get temp {
    switch (availability) {
      case Availability.Available:
        return 'Available';
        break;
      case Availability.Unvailable:
        return 'Unavailable';
        break;

      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Color.fromARGB(108, 0, 0, 0),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextHighlight(
                      text: title,
                      textStyle: TextStyle(
                        fontFamily: "heroiccondensed-medium",
                        fontSize: 23,
                        color: Color.fromARGB(255, 223, 222, 222),
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      words: {},
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.shelves),
                        SizedBox(
                          width: 6,
                        ),
                        Text(temp),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text("${rating}"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(
                          width: 6,
                        ),
                        Text("${Price} \$"),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}