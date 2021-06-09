import 'package:flutter/material.dart';
import 'package:memorygame_fyp1/data.dart';
import 'package:memorygame_fyp1/flipcardgame.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) => _list[index].goto,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: _list[index].secondarycolor,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black38,
                                  spreadRadius: 0.5,
                                  offset: Offset(3, 4))
                            ]),
                      ),
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: _list[index].primarycolor,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black12,
                                  spreadRadius: 0.3,
                                  offset: Offset(5, 3))
                            ]),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              _list[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(3, 2),
                                    ),
                                    Shadow(
                                        color: Colors.green,
                                        blurRadius: 2,
                                        offset: Offset(1, 2))
                                  ]),
                            )),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: generatstar(_list[index].noOfstar)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  List<Widget> generatstar(int no) {
    List<Widget> _icons = [];
    for (int i = 0; i < no; i++) {
      _icons.insert(
          i,
          Icon(
            Icons.star,
            color: Colors.yellow,
          ));
    }
    return _icons;
  }
}

class Details {
  String name;
  Color primarycolor;
  Color secondarycolor;
  Widget goto;
  int noOfstar;
  Details(
      {required this.name,
      required this.primarycolor,
      required this.secondarycolor,
      required this.noOfstar,
      required this.goto});
}

List<Details> _list = [
  Details(
      name: "EASY",
      primarycolor: Colors.green.shade400,
      secondarycolor: Colors.green.shade200,
      noOfstar: 1,
      goto: FlipCardGame(Level.Easy)),
  Details(
      name: "MEDIUM",
      primarycolor: Colors.blue.shade400,
      secondarycolor: Colors.blue.shade200,
      noOfstar: 2,
      goto: FlipCardGame(Level.Medium)),
  Details(
      name: "HARD",
      primarycolor: Colors.pink.shade400,
      secondarycolor: Colors.pink.shade200,
      noOfstar: 3,
      goto: FlipCardGame(Level.Hard)),
];
