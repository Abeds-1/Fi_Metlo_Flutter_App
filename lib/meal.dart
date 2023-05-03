import 'dart:ffi';

import 'package:flutter/cupertino.dart';

enum Availability { Available, Unvailable }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final int Price;
  final double rating;
  final Availability availability;
  final String Description;
  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imageUrl,
      required this.ingredients,
      required this.duration,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian,
      required this.steps,
      required this.Price,
      required this.rating,
      required this.availability,
      required this.Description
      });
}