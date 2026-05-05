import 'package:expense_app/data/helper/db_helper.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_event.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  DBHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()){
    on<AddExpenseEvent>((event, state) async{
      emit(ExpenseLoadingState());
      bool isAdded =await dbHelper.addExpense(expModel: event.newExpenseModel);
      if(isAdded){
        emit(ExpenseLoadedState(allExpenses: await dbHelper.fetchAllExpense()));
      }else{
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<FetchExpenseEvent>((event, state) async{
      emit(ExpenseLoadingState());

      emit(ExpenseLoadedState(allExpenses: await dbHelper.fetchAllExpense()));
    });

    on<DeleteExpenseEvent>((event, state) async{
      emit(ExpenseLoadingState());

      bool isDeleted = await dbHelper.deleteExpense(expId: event.expenseId);
      if(isDeleted){
        emit(ExpenseLoadedState(allExpenses: await dbHelper.fetchAllExpense()));
      }else{
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }
    });


    on<UpdateExpenseEvent>((event, state) async{
      emit(ExpenseLoadingState());

      bool isUpdated = await dbHelper.updateExpense(updateExp: event.updateExpenseModel);
      if(isUpdated){
        emit(ExpenseLoadedState(allExpenses: await dbHelper.fetchAllExpense()));
      }else{
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }
    });
  }
}