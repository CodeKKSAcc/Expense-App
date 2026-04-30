

import 'package:expense_app/data/model/category_model.dart';

class AppConstants {

  static const String pref_user_key = "User_id";

  static final List<CategoryModel> myCategory = [
    CategoryModel(id: 1, title: "Restaurant", imagePath: "assets/images/restaurant.png"),
    CategoryModel(id: 2, title: "Movie", imagePath: "assets/images/film-slate.png"),
    CategoryModel(id: 3, title: "Shopping", imagePath: "assets/images/trolley.png"),
    CategoryModel(id: 4, title: "Snacks", imagePath: "assets/images/snack.png"),
    CategoryModel(id: 5, title: "Fuel", imagePath: "assets/images/petrol.png"),
    CategoryModel(id: 6, title: "Travel", imagePath: "assets/images/travel.png"),
    CategoryModel(id: 7, title: "Fast-Food", imagePath: "assets/images/fast-food.png"),
  ];

}