import 'package:flutter/material.dart';
import 'package:fimetlo/Categories/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final Color textcolor;
  final String image;

  CategoryItem(this.id, this.title, this.color, this.textcolor, this.image);
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    late Size screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 130 / 732 * screenSize.height,
        width: 130 / 412 * screenSize.width,
        margin: EdgeInsets.only(right: 10),
       padding: EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 18,
                    fontFamily: 'POPPINS',
                    fontWeight: FontWeight.bold,
                  )),
        
                  Container(
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fitHeight,
            ),),)
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
              //offset: Offset(2, 2.5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}