
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';


class WiFi extends StatefulWidget {
  WiFi({Key key, this.title}) : super(key: key);
  final String title;



  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<WiFi> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _dataString2 = "";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  final TextEditingController _textController2 =  TextEditingController();




  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("WiFi QR Code Generator"),
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.wifi),
                      hintText: 'Enter your WiFi SSID',
                      labelText: 'SSID',
                    ),
                  ),
                  new TextFormField(
                    controller: _textController2,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.wifi_lock),
                      hintText: 'Enter your WiFi password',
                      labelText: 'Password',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child:  FlatButton(
                      color: Colors.lightBlueAccent,
                      child:  Text("GENERATE"),
                      onPressed: () {
                        setState((){
                          _dataString = _textController.text;
                          _dataString2 = _textController2.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: _dataString + "\r\n" + _dataString2,
                        size: 0.4 * bodyHeight,
//                        onError: (ex) {
//                          print("[QR] ERROR - $ex");
//                          setState(() {
//                            _inputErrorText =
//                            "Error! Maybe your input value is too long?";
//                          });
//                        },
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
