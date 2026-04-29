
import 'package:flutter/material.dart';

class ChartNavPage extends StatelessWidget {
  const ChartNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistic",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        actions: [
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
          SizedBox(width: 15,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top status bar
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff6674D3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.87, -0.63),
                    child: Text(
                      "Total expense",
                      style: TextStyle(fontSize: 17.1, color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.78, 0.12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "\$3, 734",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 9,),
                        Text("/ \$4000 per month", style: TextStyle(fontSize: 18, color: Colors.white54),)
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.78, 0.75),
                    child: Container(
                      height: 9,
                      width: double.infinity,
                      alignment: Alignment(1, 1),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.amber
                      ),
                      child: Container(
                        height: 9,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.indigoAccent.shade100
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 21,),
            // Expense breakdown title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Expense Breakdown", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                    Text("Limit \$900 / week", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),)
                  ],
                ),
                Spacer(),
                Container(
                  alignment: Alignment(0, 0),
                  height: 33,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.blue.shade100,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Week", style: TextStyle(fontSize: 18),),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 21,),
            //Statistics plot
            Container(
              height: 210,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  border: Border.all()
              ),
            ),
            // Spending Details title
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Text("Spending Details", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
            ),
            Text("Your expenses are divided in 6 categories", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
            SizedBox(height: 15,),
            // Statistics bar
            Container(
              height: 90,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 9,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.indigo
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text("40%")
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 9,
                              width: 81,
                              color: Colors.pinkAccent,
                            ),
                            SizedBox(height: 15),
                            Text("25%")
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 9,
                              width: 69,
                              color: Colors.amber,
                            ),
                            SizedBox(height: 15,),
                            Text("15%")
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 9,
                              width: 54,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 15,),
                            Text("10%")
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 9,
                              width: 30,
                              color: Colors.red,
                            ),
                            SizedBox(height: 15,),
                            Text("5%")
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 9,
                              width: 30,
                              color: Colors.green,
                            ),
                            SizedBox(height: 15,),
                            Text("5%")
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Spend icons
            Row(
              children: [
                Container(
                  alignment: Alignment(-0.6, 0),
                  height: 90,
                  width: 180,
                  margin: EdgeInsets.only(right: 18),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(9)
                  ),
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
                      SizedBox(width: 12,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Shop", style: TextStyle(fontSize: 18),),
                          SizedBox(height: 6,),
                          Text("-\$1190", style: TextStyle(fontSize: 18, color: Colors.pinkAccent),)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment(0, 0),
                  height: 90,
                  width: 180,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(9)
                  ),
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
                      SizedBox(width: 12,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              width: 90,
                              child: Text("Transportation", maxLines: 1, style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis, ),))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}