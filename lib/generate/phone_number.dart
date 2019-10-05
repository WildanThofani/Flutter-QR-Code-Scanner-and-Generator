import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PhoneNumber extends StatefulWidget {
  PhoneNumber({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<PhoneNumber> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Phone Number QR Code Generator"),
        ),
        body: new SafeArea(
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child:  FlatButton(
                      color: Colors.lightBlueAccent,
                      child:  Text("GENERATE"),
                      onPressed: () {
                        setState((){
                          _dataString = _textController.text;
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
                        data: _dataString,
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
