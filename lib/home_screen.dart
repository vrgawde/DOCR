import 'package:flutter/material.dart';
import 'CameraScreen/camera.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "OCR",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  options("Pan Card", Colors.lightBlue, "lib/assets/pan.png"),
                  options(
                      "Aadhar Card", Colors.deepOrange, "lib/assets/aadhar.png")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  options("Pan Card 2", Colors.redAccent, "lib/assets/pan.png"),
                  options("Voting Card", Colors.grey, "lib/assets/voter.png")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  options("Driving License", Colors.greenAccent,
                      "lib/assets/driver.png"),
                  options("Bank Cheque", Colors.purpleAccent,
                      "lib/assets/cheque.png")
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget options(String name, Color color, String path) {
    return Expanded(
      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.all(
//            Radius.circular(10.0),
//          ),
//        ),
        height: 150.0,
        width: 150.0,
        margin: EdgeInsets.all(25.0),
        child: InkWell(
          child: RaisedButton(
            elevation: 15.0,
            color: color,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 100.0,
                  child: Image.asset(path),
                ),
                Text(name)
              ],
            ),
            onPressed: () {
              setState(() {
                switch (name) {
                  case "Pan Card":
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera("pan")));
                      break;
                    }
                  case "Pan Card 2":
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera("pan2")));
                      break;
                    }
                  case "Aadhar Card":
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera("Aadhar Card")));
                      break;
                    }
                  case "Driving License":
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera("Driving License")));
                      break;
                    }
                  case "Voting Card":
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera("Voting Card")));
                      break;
                    }
                  default:
                    print("Nothing");
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
