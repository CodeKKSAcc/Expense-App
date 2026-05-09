import 'package:expense_app/data/helper/db_helper.dart';
import 'package:expense_app/data/model/category_model.dart';
import 'package:expense_app/data/model/expense_model.dart';
import 'package:expense_app/data/model/filter_expense_model.dart';
import 'package:expense_app/domain/constants/app_constants.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_event.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
    DBHelper dbHelper;

    ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
        on<AddExpenseEvent>((event, state) async {

                emit(ExpenseLoadingState());
                bool isAdded = await dbHelper.addExpense(expModel: event.newExpenseModel);

                if (isAdded) {

                  bool isBalanceUpdated = await dbHelper.updateBalence(expModel: event.newExpenseModel);

                    List<ExpenseModel> allExp = await dbHelper.fetchAllExpense();
                    emit(ExpenseLoadedState(
                            allExpenses: filterExpenseByType(allExpenses: allExp)));
                } else {
                    emit(ExpenseErrorState(errorMsg: "Something went wrong"));
                }
            });

        on<FetchExpenseEvent>((event, state) async {
                emit(ExpenseLoadingState());

                List<ExpenseModel> allExp = await dbHelper.fetchAllExpense();
                emit(ExpenseLoadedState(
                        allExpenses: filterExpenseByType(allExpenses: allExp, type: event.filterType)));
            });

        on<DeleteExpenseEvent>((event, state) async{
                emit(ExpenseLoadingState());

                bool isDeleted = await dbHelper.deleteExpense(expId: event.expenseId);
                List<ExpenseModel> allExp = await dbHelper.fetchAllExpense();
                if (isDeleted) {
                    emit(ExpenseLoadedState(allExpenses: filterExpenseByType(allExpenses: allExp)));
                } else {
                    emit(ExpenseErrorState(errorMsg: "Something went wrong"));
                }
            });

        on<UpdateExpenseEvent>((event, state) async{
                emit(ExpenseLoadingState());

                bool isUpdated = await dbHelper.updateExpense(updateExp: event.updateExpenseModel);
                List<ExpenseModel> allExp = await dbHelper.fetchAllExpense();
                if (isUpdated) {
                    emit(ExpenseLoadedState(allExpenses: filterExpenseByType(allExpenses: allExp)));
                } else {
                    emit(ExpenseErrorState(errorMsg: "Something went wrong"));
                }
            });
    }
    List<FilterExpenseModel> filterExpenseByType({required List<ExpenseModel> allExpenses, int type = 1}) {
        List<FilterExpenseModel> listFilterExpModel = [];

        // Or ->>> Use set to store unique dates
        // Set<String> uniqueDatesSet = {};

        if (type < 3) {

            DateFormat df = DateFormat();

            List<String> uniqueDates = [];

            if (type == 0) {
                df = DateFormat.yMMMMEEEEd();
            }
            if (type == 1) {
                df = DateFormat.yMMMM();
            }
            else if (type == 2) {
                df = DateFormat.y();
            }

            for (ExpenseModel eachExp in allExpenses){
                String eachExpDate = df.format(DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt));
                if (!uniqueDates.contains(eachExpDate)) {
                    uniqueDates.add(eachExpDate);
                }
                // Or ->>> Using set to store unique dates
                //uniqueDatesSet.add(eachExpDate);
            }

            // Filter data as per unique dates
            for (String eachDate in uniqueDates){
                num eachTypeExpBalence = 0;
                List<ExpenseModel> eachTypeExp = [];

                for (ExpenseModel eachExp in allExpenses){
                    String eachExpDate = df.format(DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt));
                    if (eachDate == eachExpDate) {
                        eachTypeExp.add(eachExp);

                        if (eachExp.type == 0) {
                            eachTypeExpBalence -= eachExp.amount;
                        } else {
                            eachTypeExpBalence += eachExp.amount;
                        }
                    }
                }

                listFilterExpModel.add(FilterExpenseModel(title: eachDate, balence: eachTypeExpBalence, myExp: eachTypeExp));

            }
        }
        else {
            for (CategoryModel eachCat in AppConstants.myCategory){
                num eachTypeExpBalence = 0;
                List<ExpenseModel> eachTypeExp = [];

                for (ExpenseModel eachExp in allExpenses){
                    if (eachCat.id == eachExp.categoryId) {
                        eachTypeExp.add(eachExp);

                        if (eachExp.type == 0) {
                            eachTypeExpBalence -= eachExp.amount;
                        } else {
                            eachTypeExpBalence += eachExp.amount;
                        }
                    }
                }

                if (eachTypeExp.isNotEmpty) {
                    listFilterExpModel.add(FilterExpenseModel(
                        title: eachCat.
                        title, balence: eachTypeExpBalence,
                        myExp: eachTypeExp));
                }

            }
        }

        return listFilterExpModel;
    }

}