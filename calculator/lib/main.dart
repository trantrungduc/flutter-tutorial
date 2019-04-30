
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,

      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
  
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ["Rupees","Dollars","Pounds"];
  var _currentItemSelected='';

  @override
  void initState(){
    super.initState();
    _currentItemSelected=_currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult='';

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Calculator")),
      body:Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Center(child: getImageLogo()),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  style: textStyle,
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g. 12000',
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: roiController,
                  style: textStyle,
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Please enter ROI';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In Percent',
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: termController,
                        style: textStyle,
                        validator: (String value){
                          if (value.isEmpty){
                            return 'Please enter term amount';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in Years',
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          )
                        ),
                      ),
                    ),
                    Container(width: 20.0,),
                    Expanded(
                      child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String dropItem){
                          return DropdownMenuItem<String>(
                            value: dropItem,
                            child: Text(dropItem),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValue){
                          setState(() {
                          this._currentItemSelected=newValue; 
                          });
                        },
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        child: Text("Calculate",style: textStyle,),
                        onPressed: (){
                          setState(() {
                            if (_formKey.currentState.validate()){
                              double princial = double.parse(principalController.text);
                              double roi = double.parse(roiController.text);
                              double term = double.parse(termController.text);

                              double totalAmountPayable = princial+(princial*roi*term)/100;
                              displayResult = 'After $term years, your investment will be worth $totalAmountPayable';
                            }
                          });
                        },
                      ),
                    ),
                    Container(width: 20.0,),
                    Expanded(
                      child: RaisedButton(
                        child: Text("Reset",style: textStyle,),
                        onPressed: (){
                          setState(() {
                          principalController.text='';
                          roiController.text='';
                          termController.text='';
                          displayResult='';
                          _currentItemSelected=_currencies[0]; 
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(displayResult,style: textStyle,)
              )
            ],
          ),
        )
      )
    );
  }
  
}

Widget getImageLogo(){
  AssetImage logo = AssetImage("images/dollar.png");
  return Image(image: logo,width: 100.0,);
}