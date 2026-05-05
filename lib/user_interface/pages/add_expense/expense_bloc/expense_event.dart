
import 'package:expense_app/data/model/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpenseModel;
  AddExpenseEvent({required this.newExpenseModel});
}

class FetchExpenseEvent extends ExpenseEvent{}

class DeleteExpenseEvent extends ExpenseEvent{
  int expenseId;
  DeleteExpenseEvent({required this.expenseId});
}

class UpdateExpenseEvent extends ExpenseEvent{
  ExpenseModel updateExpenseModel;
  UpdateExpenseEvent({required this.updateExpenseModel});
}