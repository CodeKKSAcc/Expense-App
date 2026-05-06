
import 'package:expense_app/data/model/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpenseModel;
  AddExpenseEvent({required this.newExpenseModel});
}

class FetchExpenseEvent extends ExpenseEvent{
  int filterType; // 0 = Month, 1 = Year

  FetchExpenseEvent({this.filterType = 0});
}

class DeleteExpenseEvent extends ExpenseEvent{
  int expenseId;
  DeleteExpenseEvent({required this.expenseId});
}

class UpdateExpenseEvent extends ExpenseEvent{
  ExpenseModel updateExpenseModel;
  UpdateExpenseEvent({required this.updateExpenseModel});
}