import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.brown),
          home: HomePage()),
    );

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {

    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    animation = animationController;

    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {

    showDatePicker(
            context: context,
            initialDate: DateTime(2020),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      setState(() {
        selectedYear = dt.year;
        calculateAge();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              child: Text(selectedYear == null
                  ? "Select your year of birth"
                  : "$selectedYear"),
              borderSide: BorderSide(color: Colors.black, width: 3.0),
              color: Colors.white,
              onPressed: _showPicker,
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            Text(
              "Your Age is ${animation.value.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void calculateAge() {
    setState(() {
      age = (DateTime.now().year - selectedYear).toDouble();
      animation = Tween<double>(begin: animation.value, end: age).animate(
          CurvedAnimation(
              parent: animationController, curve: Curves.fastOutSlowIn));
    });

    animation.addListener((){
      setState(() {

      });
    });

    animationController.forward();
  }
}
