import 'package:flutter/material.dart';

class PanResponse extends StatefulWidget {
  Map response;
  String name, father, dob, pan;

  PanResponse(this.response);
  @override
  _PanResponseState createState() => _PanResponseState();
}

class _PanResponseState extends State<PanResponse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Name: ${widget.response['name']}",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                "Father Name: ${widget.response['father']}",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                "DOB: ${widget.response['dob']}",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(
                "PAN: ${widget.response['pan']}",
                style: TextStyle(fontSize: 30.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
