import 'package:flutter/material.dart';

void main() {
  runApp(IntroPage());
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 27,
                width: 27,
                fit: BoxFit.fill,
              ),
              Text(
                "Monety",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, 0.6),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Image.asset("assets/images/background_color.png"),
                ),
              ),
              Align(
                alignment: Alignment(-0.3, -0.72),
                child: Padding(
                  padding: EdgeInsets.only(right: 12, left: 12, bottom: 54),
                  child: Image.asset(
                    "assets/images/intro_icon.png",
                    /*height: 240,
                    width: 120,*/
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, .33),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Easy way to monitor your expense",
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, .54),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "Safe your future by managing your expense right now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      wordSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(1, 0.84),
                child: Container(
                  height: 90,
                  width: 78,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12))
                  ),
                ),
              ),
              Align(
                alignment: Alignment(1, 0.81),
                child: SizedBox(
                  height: 63,
                  width: 63,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Color(0xffE98DBC),
                    child: Icon(Icons.arrow_forward, size: 27, color: Colors.white,),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.69),
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: EdgeInsets.only(left: 21),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    Container(
                      height: 12,
                      width: 12,
                      margin: EdgeInsets.only(left: 9),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(6)
                      ),
                    ),
                    Container(
                      height: 12,
                      width: 12,
                      margin: EdgeInsets.only(left: 9),
                      decoration: BoxDecoration(
                          color: Colors.amber.shade300,
                          borderRadius: BorderRadius.circular(6)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// E98DBC
