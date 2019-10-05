import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class URL extends StatefulWidget {
  URL({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<URL> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GlobalKey globalKey = new GlobalKey();
  String _dataStringTitle = "Hello from this QR";
  String _dataStringUrl = "";
  String _inputErrorText;
  final TextEditingController _textControllerTitle =  TextEditingController();
  final TextEditingController _textControllerUrl =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("URL QR Code Generator"),
      ),
        body: new SafeArea(
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    controller: _textControllerTitle,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.title),
                      hintText: 'Enter your URL or Web title',
                      labelText: 'URL or Web Title',
                    ),
                  ),
                  new TextFormField(
                    controller: _textControllerUrl,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.web),
                      hintText: 'Enter your URL or Web link',
                      labelText: 'URL or Web Link',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child:  FlatButton(
                      color: Colors.lightBlueAccent,
                      child:  Text("GENERATE"),
                      onPressed: () {
                        setState((){
                          _dataStringTitle = _textControllerTitle.text;
                          _dataStringUrl = _textControllerUrl.text;
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
                        data: _dataStringTitle + "\r\n" + "https://" + _dataStringUrl,
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

//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
                ]),
          ),
        )
    );
  }
}