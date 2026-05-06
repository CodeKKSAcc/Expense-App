import 'package:expense_app/data/model/filter_expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState{}

class ExpenseLoadingState extends ExpenseState{}

class ExpenseLoadedState extends ExpenseState{
  List<FilterExpenseModel> allExpenses;
  ExpenseLoadedState({required this.allExpenses});
}

class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}
