import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        padding:  EdgeInsets.all(10.0),
        alignment: Alignment.center,
        color: Colors.deepPurple,
        //width: 200.0,
        //height: 100.0,
        //margin: EdgeInsets.only(left:15.0),
        //padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FlightImageSet(),
                Expanded(
                  child: Text("Spice Jet", style: TextStyle(fontSize: 14.0,color: Colors.white,decoration: TextDecoration.none),)
                ),
                Expanded(
                  child: Text("From Mumbai to Bangalore via New Delhi", style: TextStyle(fontSize: 14.0,color: Colors.white,decoration: TextDecoration.none))
                ),
                FlightBookButton()
              ],
            ),
            Row(
              children: <Widget>[
                FlightImageSet(),
                Expanded(
                  child: Text("Spice Jet", style: TextStyle(fontSize: 14.0,color: Colors.white,decoration: TextDecoration.none),)
                ),
                Expanded(
                  child: Text("From Mumbai to Bangalore via New Delhi", style: TextStyle(fontSize: 14.0,color: Colors.white,decoration: TextDecoration.none))
                ),
                FlightBookButton()
              ],
            )
          ]
        )
      )
    );
  }
}

class FlightImageSet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage aimg = AssetImage('images/flight.png');
    Image img = Image(image: aimg,);
    return Container(child: img,);
  }
  
}

class FlightBookButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: 100.0,
      height: 30.0,
      child: RaisedButton(
        color: Colors.deepOrange,
        child: Text('Booking',style: TextStyle(color: Colors.white),),
        elevation: 6.0,
        onPressed: () => bookFlight(context)),
      );
  }

  void bookFlight(BuildContext context){
    var alert = AlertDialog(
      title: Text("Flight booked successfull!"),
      content: Text("Have a pleasant flight"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert
    );
  }
  
}