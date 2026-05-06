import 'package:expense_app/data/model/expense_model.dart';
import 'package:expense_app/domain/constants/app_constants.dart';
import 'package:expense_app/domain/utility/ui_helper.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_bloc.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_event.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatelessWidget {

  TextEditingController titleControl = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<String> expenseType = ["Debit", "Credit"];
  int selectedTypeIndex = 0;
  int selectedCategoryIndex = -1;

  DateFormat myDf = DateFormat.yMMMMEEEEd();
  DateTime? myDateTime;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              return updateUi(toUpdate: true);
            },
          ),
    ),);
  }

  Widget updateUi({required bool toUpdate}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          SizedBox(height: 27),
          TextField(
            controller: titleControl,
            decoration: myIpDecoration(
              myHintText: "Enter your title here",
              myLabelText: "Title",
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: remarkController,
            decoration: myIpDecoration(
              myHintText: "Enter your remark here",
              myLabelText: "Remark",
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: amountController,
            decoration: myIpDecoration(
              myHintText: "Enter your amount here",
              myLabelText: "Amount",
            ),
          ),
          SizedBox(height: 15),
          DropdownMenuFormField(
            width: double.infinity,
            label: Text("Type"),
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.pinkAccent, width: 2.4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            initialSelection: selectedTypeIndex,
            onSelected: (value) {
              selectedTypeIndex = value!;
            },
            dropdownMenuEntries: List.generate(expenseType.length, (index) {
              return DropdownMenuEntry(value: index, label: expenseType[index]);
            }),
          ),
          /* StatefulBuilder(
                builder: (context, mySs) {
                  return DropdownButton(
                    items: List.generate(expenseType.length, (index){
                      return DropdownMenuItem(child: Text(expenseType[index]), value: index,);
                    }),
                    value: selectedTypeIndex,
                    onChanged: (value) {
                      selectedTypeIndex = value!;
                      mySs(() {});
                    },
                  );
                },
              ),*/
          // Or ->>>
          // expenseType.map((e) {
          //  return DropdownMenuItem(child: Text(e), value: e);
          //  }).toList()

          // Or ->>>
          /*[
                 DropdownMenuItem(child: Text("Debit"), value: "Debit",),
                 DropdownMenuItem(child: Text("Credit"), value: "Credit",),
                    ],*/
          SizedBox(height: 15),
          StatefulBuilder(
            builder: (context, sS) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(54),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Choose a Category",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 18),
                            Expanded(
                              child: GridView.builder(
                                itemCount: AppConstants.myCategory.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      selectedCategoryIndex = index;
                                      Navigator.pop(context);
                                      sS(() {});
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          AppConstants
                                              .myCategory[index]
                                              .imagePath,
                                          height: 51,
                                          width: 51,
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          AppConstants.myCategory[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment(0, 0),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(width: 1.5),
                  ),
                  child: selectedCategoryIndex >= 0
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppConstants
                            .myCategory[selectedCategoryIndex]
                            .imagePath,
                        height: 51,
                        width: 51,
                      ),
                      SizedBox(width: 27),
                      Text(
                        "- ${AppConstants.myCategory[selectedCategoryIndex]
                            .title}",
                      ),
                    ],
                  )
                      : Text("Chose Category"),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          StatefulBuilder(
            builder: (context, sS) {
              return InkWell(
                onTap: () async {
                  DateTime? userSelectedDate = await showDatePicker(
                    currentDate: myDateTime ?? DateTime.now(),
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 366)),
                    // DateTime(2024)
                    lastDate: DateTime.now(),
                  );
                  if(userSelectedDate != null){
                    myDateTime = userSelectedDate;
                  }
                  else{
                    myDateTime ??= DateTime.now();
                  }
                  sS(() {});
                },
                child: Container(
                  alignment: Alignment(0, 0),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(width: 1.5),
                  ),
                  child: Text(
                    "Created Time  -   ${myDf.format(
                        myDateTime ?? DateTime.now())}",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state is ExpenseLoadingState) {
                isLoading = true;
              }
              if (state is ExpenseLoadedState) {
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Expense ${toUpdate
                        ? "Updated"
                        : "Added"} Successfully..."),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              }
              if (state is ExpenseErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMsg),
                    backgroundColor: Colors.red,
                  ),
                );
                isLoading = false;
              }
            },

            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (selectedCategoryIndex >= 0) {
                    SharedPreferences myPref =
                    await SharedPreferences.getInstance();

                    context.read<ExpenseBloc>().add(
                      AddExpenseEvent(
                        newExpenseModel: ExpenseModel(
                          uid:
                          myPref.getInt(AppConstants.pref_user_key) ??
                              0,
                          categoryId: AppConstants
                              .myCategory[selectedCategoryIndex]
                              .id,
                          createdAt: (myDateTime ?? DateTime.now())
                              .millisecondsSinceEpoch,
                          type: selectedTypeIndex,
                          title: titleControl.text,
                          remark: remarkController.text,
                          amount: num.parse(amountController.text),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(double.infinity, 60),
                  minimumSize: Size(double.infinity, 60),
                  backgroundColor: Colors.pink.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(21),
                  ),
                ),
                child: isLoading
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Adding Expenses...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
                    : Text(
                  "Add Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
