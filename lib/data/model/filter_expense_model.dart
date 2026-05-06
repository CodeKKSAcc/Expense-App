import 'package:expense_app/data/model/expense_model.dart';

class FilterExpenseModel {
  String title;
  num balence;
  List<ExpenseModel> myExp;

  FilterExpenseModel({
    required this.title,
    required this.balence,
    required this.myExp,
  });
}
