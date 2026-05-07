import 'dart:math';
import 'package:expense_app/data/model/category_model.dart';
import 'package:expense_app/data/model/expense_model.dart';
import 'package:expense_app/data/model/filter_expense_model.dart';
import 'package:expense_app/domain/constants/app_constants.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_bloc.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_event.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeNavPage extends StatefulWidget {
    const HomeNavPage({super.key});

    @override
    State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {

    DateFormat myDf = DateFormat.yMMMMEEEEd();

    // Month Wise, Year Wise, Category Wise filtering
    List<String> filterType = ["Date-wise", "Month-Wise", "Year-Wise", "Category-wise"];
    int filterTypeIndex = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    children: [
                        Image.asset(
                            "assets/images/logo.png",
                            height: 27,
                            width: 27,
                            fit: BoxFit.fill,
                        ),
                        Text("Monety", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                ),
                actions: [Icon(Icons.search, size: 36), SizedBox(width: 12)],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    children: [
                        Row(
                            children: [
                                Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22.5),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/user.png"),
                                            fit: BoxFit.fill,
                                        ),
                                    ),
                                ),
                                SizedBox(width: 9),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            "Morning",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                        ),
                                        Text(
                                            "Blaszczykowski", //Blaszczykowski
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ],
                                ),
                                Spacer(),
                                DropdownMenuFormField(
                                    width: 180,
                                    inputDecorationTheme: InputDecorationTheme(
                                        fillColor: Colors.blue.shade100,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(18),
                                            borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(18),
                                            borderSide: BorderSide.none
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(18),
                                            borderSide: BorderSide.none
                                        ),
                                    ),
                                    initialSelection: filterTypeIndex,
                                    onSelected: (value) {
                                        filterTypeIndex = value!;
                                        setState(() {
                                                context.read<ExpenseBloc>().add(FetchExpenseEvent(filterType: filterTypeIndex));
                                            });
                                    },
                                    dropdownMenuEntries: List.generate(filterType.length, (index) {
                                            return DropdownMenuEntry(value: index, label: filterType[index]);
                                        }),
                                ),
                            ],
                        ),
                        SizedBox(height: 24,),
                        Expanded(
                            child: BlocBuilder<ExpenseBloc, ExpenseState>(
                                builder: (context, state) {
                                    if (state is ExpenseLoadingState) {
                                        return Center(child: CircularProgressIndicator());
                                    }

                                    if(state is ExpenseErrorState){
                                        return Center(child: Text(state.errorMsg),);
                                    }

                                    if (state is ExpenseLoadedState) {
                                        return state.allExpenses.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: state.allExpenses.length,
                                                itemBuilder: (context, index) {

                                                    FilterExpenseModel eachFilteredExpense = state.allExpenses[index];

                                                    return Container(
                                                        padding: EdgeInsets.all(6),
                                                        margin: EdgeInsets.only(bottom: 12),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadiusGeometry.circular(12),
                                                            border: BoxBorder.all()
                                                        ),
                                                        child: Column(
                                                            children: [
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                        Text(eachFilteredExpense.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        Text(eachFilteredExpense.balence.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                                                    ],
                                                                ),
                                                                SizedBox(height: 12,),
                                                                Divider(),
                                                                ListView.builder(
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    itemCount: eachFilteredExpense.myExp.length,
                                                                    shrinkWrap: true,
                                                                    itemBuilder: (context, childIndex) {

                                                                        ExpenseModel eachExp = eachFilteredExpense.myExp[childIndex];

                                                                        String eachExpCatImage = "";
                                                              /*CategoryModel expCatModel = AppConstants.myCategory.where((e){
                                                                  return e.id ==  eachExp.categoryId ;
                                                              }).toList()[0] ;*/
                                                                        // Or just
                                                                        CategoryModel expCatModel = AppConstants.myCategory.firstWhere((e) {
                                                                                return e.id == eachExp.categoryId;
                                                                            });

                                                                        eachExpCatImage = expCatModel.imagePath;

                                                                        return ListTile(
                                                                            titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Poppins", color: Colors.black),
                                                                            subtitleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Poppins", color: Colors.black54),
                                                                            contentPadding: EdgeInsets.zero,
                                                                            leading: Container(
                                                                                alignment: Alignment(0, 0),
                                                                                height: 60,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                                                                                    borderRadius: BorderRadius.circular(9),
                                                                                    image: DecorationImage(image: AssetImage(eachExpCatImage,), fit: BoxFit.fill)
                                                                                ),
                                                                            ),
                                                                            title: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                    Text(eachFilteredExpense.title),
                                                                                    Text(eachExp.amount.toString(), style: TextStyle(
                                                                                            color: eachExp.type == 0 ? Colors.red :
                                                                                                Colors.green))
                                                                                ],
                                                                            ),
                                                                            subtitle: Text(eachExp.remark),
                                                                        );
                                                                    })
                                                            ],
                                                        ),
                                                    );
                                                },
                                            )
                                            : Center(
                                                child: Text(
                                                    "No Expenses Yet !!!",
                                                    style: TextStyle(
                                                        fontSize: 27,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            );
                                    }

                                    if (state is ExpenseErrorState) {
                                        return Center(child: Text(state.errorMsg));
                                    }

                                    return Container();
                                },
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}

/*
class HomeNavPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 27,
              width: 27,
              fit: BoxFit.fill,
            ),
            Text("Monety", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [Icon(Icons.search, size: 36), SizedBox(width: 12)],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 21, left: 21, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User icon and details
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.5),
                    image: DecorationImage(
                      image: AssetImage("assets/images/user.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 9),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Morning",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      "Blaszczykowski",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox(width: 3)),
                Container(
                  height: 33,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.blue.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("This month", style: TextStyle(fontSize: 15)),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 27),
            // Total expense section
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff6674D3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.87, -0.72),
                    child: Text(
                      "Expense total",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.87, 0),
                    child: Text(
                      "\$3, 734",
                      style: TextStyle(
                        fontSize: 51,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.87, 0.81),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment(0, 0),
                          height: 27,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "+\$240",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          "than last month",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 0),
                    child: Image.asset(
                      "assets/images/balance_icon.png",
                      height: 120,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            // Expense List title
            Text("Expense List", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            // Expense List section
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Top bar -> Day & Expense
                  Container(
                    height: 42,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 9),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: Row(
                      children: [
                        Text("Tuesday, 14", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text("-\$1380", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // Icons
                  Align(
                    alignment: Alignment(-1, -0.15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 51,
                            width: 51,
                            decoration: BoxDecoration(
                              color: Color(0xffD8DBEB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.indigoAccent,
                            ),
                          ),
                          SizedBox(width: 9),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shop", style: TextStyle(fontSize: 18)),
                              Text(
                                "Buy new clothes",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "-\$90",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, 0.78),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 51,
                            width: 51,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.mobile_screen_share_rounded,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          SizedBox(width: 9),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Electronic",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Buy now iphone 14",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "-\$1290",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18,),
            // Next expense section -> Monday
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 9),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide())
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Monday, 13", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text("-\$60", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, 0.6),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment(0, 0),
                            height: 51,
                            width: 51,
                            margin: EdgeInsets.only(right: 9),
                            decoration: BoxDecoration(
                                color: Colors.pink.shade50,
                                borderRadius: BorderRadius.circular(9)
                            ),
                            child: Icon(Icons.directions_car, color: Colors.pinkAccent),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Transportation", style: TextStyle(fontSize: 18),),
                              Text("Trip to Malang", style: TextStyle(fontSize: 15),)
                            ],
                          ),
                          Spacer(),
                          Text("-\$60", style: TextStyle(fontSize: 18, color: Colors.pinkAccent),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
