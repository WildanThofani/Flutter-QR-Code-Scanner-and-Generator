import 'package:barcode_numbawan/bloc/note_bloc.dart';
import 'package:barcode_numbawan/bloc/provider.dart';
import 'package:barcode_numbawan/generate/email.dart';
import 'package:barcode_numbawan/generate/phone_number.dart';
import 'package:barcode_numbawan/generate/sms.dart';
import 'package:barcode_numbawan/generate/url.dart';
import 'package:barcode_numbawan/generate/vcard.dart';
import 'package:barcode_numbawan/generate/wifi.dart';
import 'package:barcode_numbawan/models/model.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';


class GenerateScreen extends StatefulWidget {
  final NoteBloc bloc;

  GenerateScreen(this.bloc);


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<GenerateScreen> {
  String _selectedQR = null;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey globalKey = new GlobalKey();

  ///String
  String _dataStringName         = "QR Code";
  String _dataStringAddress      = "";
  String _dataStringPhone        = "";
  String _dataStringEmail        = "";
  String _dataStringOrganization = "";
  String _dataStringJobTitle     = "";
  String _dataStringURL          = "";

  ///Controller
 TextEditingController _textControllerName;
 TextEditingController _textControllerAddress;
 TextEditingController _textControllerPhone;
 TextEditingController _textControllerEmail;
 TextEditingController _textControllerOrganization;
 TextEditingController _textControllerJobTitle;
 TextEditingController _textControllerURL;

  @override
  void initState() {
    super.initState();
    ///text controller
    _textControllerName = TextEditingController();
    _textControllerAddress = TextEditingController();
    _textControllerPhone = TextEditingController();
    _textControllerEmail = TextEditingController();
    _textControllerOrganization = TextEditingController();
    _textControllerJobTitle = TextEditingController();
    _textControllerURL = TextEditingController();
  }

//  ///text controller
//  final TextEditingController _textControllerName = TextEditingController();
//  final TextEditingController _textControllerAddress = TextEditingController();
//  final TextEditingController _textControllerPhone = TextEditingController();
//  final TextEditingController _textControllerEmail = TextEditingController();
//  final TextEditingController _textControllerOrganization = TextEditingController();
//  final TextEditingController _textControllerJobTitle = TextEditingController();
//  final TextEditingController _textControllerURL = TextEditingController();

  String _inputErrorText;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('QR Generator'),
        actions: <Widget>[
          DropdownButton(
            value: _selectedQR,
            items: _dropDownItem(),
            onChanged: (value) {
              _selectedQR = value;
              switch (value) {
                case "VCard":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VCard()),
                  );
                  break;
                case "URL":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => URL()),
                  );
                  break;
                case "Email":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Email()),
                  );
                  break;
                case "SMS":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SMS()),
                  );
                  break;
                case "Phone Number":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneNumber()),
                  );
                  break;
                case "WiFi":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WiFi()),
                  );
                  break;
              }
            },
            hint: Text('Select QR Type'),
          ),
        ],
      ),
      body: new SafeArea(
        child: new Form(

          key: _formKey,
          autovalidate: true,
          child: new ListView(

              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new TextFormField(
                  controller: _textControllerName,
//                  onFieldSubmitted: (text) {
//                    widget.bloc.inSink
//                        .add(Note(body: text, state: NotesState.INSERT));
////
//                  },

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter your first and last name',
                    labelText: 'Name',
                  ),
                    onSaved: (value) => _dataStringName = value,
                ),
                new TextFormField(
                  controller: _textControllerAddress,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.store_mall_directory),
                    hintText: 'Enter your address',
                    labelText: 'Address',
                  ),
                  onSaved: (value) => _dataStringAddress = value,
                ),
                new TextFormField(
                  controller: _textControllerPhone,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'Enter a phone number',
                    labelText: 'Phone',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onSaved: (value) => _dataStringPhone = value,
                ),
                new TextFormField(
                  controller: _textControllerEmail,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Enter a email address',
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _dataStringEmail = value,
                ),
                new TextFormField(
                  controller: _textControllerOrganization,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.portrait),
                    hintText: 'Enter your Organization',
                    labelText: 'Organization',
                  ),
                  onSaved: (value) => _dataStringOrganization = value,
                ),
                new TextFormField(
                  controller: _textControllerJobTitle,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.assignment_ind),
                    hintText: 'Enter your job title',
                    labelText: 'Job Title',
                  ),
                  onSaved: (value) => _dataStringJobTitle = value,
                ),
                new TextFormField(
                  controller: _textControllerURL,

                  decoration: const InputDecoration(
                    icon: const Icon(Icons.web),
                    hintText: 'Enter your URL or web',
                    labelText: 'URL or Web',
                  ),
                  onSaved: (value) => _dataStringURL = value,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FlatButton(
                    color: Colors.lightBlueAccent,
                    child: Text("GENERATE"),
                    onPressed: () {
                         setState(() {
                      _dataStringName = _textControllerName.text;
                      _dataStringAddress = _textControllerAddress.text;
                      _dataStringPhone = _textControllerPhone.text;
                      _dataStringEmail = _textControllerEmail.text;
                      _dataStringOrganization = _textControllerOrganization.text;
                      _dataStringJobTitle = _textControllerJobTitle.text;
                      _dataStringURL = _textControllerURL.text;
                      _inputErrorText = null;
                        });

                      if (_textControllerName.text != "" &&
                          _textControllerAddress.text != "" &&
                          _textControllerPhone.text != "" &&
                          _textControllerEmail.text != "" &&
                          _textControllerOrganization.text != "" &&
                          _textControllerJobTitle.text != "" &&
                          _textControllerURL.text != "")
                      {
                        String text;

                        text =
                              "Name         : " + _dataStringName + "\r\n" +
                              "Address      : " + _dataStringAddress + "\r\n" +
                              "Phone        : " + _dataStringPhone + "\r\n" +
                              "Email        : " + _dataStringEmail + "\r\n" +
                              "Organization : " + _dataStringOrganization + "\r\n" +
                              "Job Title    : " + _dataStringJobTitle + "\r\n" +
                              "URL          : " + _dataStringURL;


//                        var data;
//                        data = {
//                          "nama" : _dataStringName,
//                          "address" : _dataStringAddress,
//                          "phone" : _dataStringPhone,
//                          "email" : _dataStringEmail,
//                          "organization" : _dataStringOrganization,
//                          "job title" : _dataStringJobTitle,
//                          "url" : _dataStringURL,
//                        };
                        widget.bloc.inSink
                        .add(Note(body: text, state: NotesState.INSERT));
                        print(text);

                      }

                    },
                  ),
                ),
                Center(
                  child: RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      backgroundColor: Colors.white,
                      data: _dataStringName + "\r\n" +
                            _dataStringAddress + "\r\n" +
                            _dataStringPhone + "\r\n" +
                            _dataStringEmail + "\r\n" +
                            _dataStringOrganization + "\r\n" +
                            _dataStringJobTitle + "\r\n" +
                            _dataStringURL,
                      size: 0.3 * bodyHeight,
//                      onError: (ex) {
//                        print("[QR] ERROR - $ex");
//                        setState(() {
//                          _inputErrorText =
//                              "Error! Maybe your input value is too long?";
//                        });
//                      },
                    ),
                  ),
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

@override
List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> qr = ["VCard", "URL", "Email", "SMS", "Phone Number", "WiFi"];
  return qr
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}


