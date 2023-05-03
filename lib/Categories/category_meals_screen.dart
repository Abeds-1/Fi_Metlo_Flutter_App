import 'package:flutter/material.dart';
import 'package:fimetlo/Categories/meal_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;
  final darkMode;
  CategoryMealsScreen(this.availableMeals, this.darkMode);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
        backgroundColor: widget.darkMode["getIsDarkMode"]()
            ? Colors.amber
            : Color(0xFFC30000),
        title: Text(
          categoryTitle,
          style: TextStyle(fontFamily: "POPPINS", color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            Price: displayedMeals[index].Price,
            rating: displayedMeals[index].rating,
            availability: displayedMeals[index].availability,
            Description: displayedMeals[index].Description,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}