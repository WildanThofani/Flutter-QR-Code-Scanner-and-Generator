import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Email extends StatefulWidget {
  Email({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<Email> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Email QR Code Generator"),
      ),
        body: new SafeArea(
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter an email address to sent',
                      labelText: 'To',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.mail_outline),
                      hintText: 'Enter a subject',
                      labelText: 'Subject',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.title),
                      hintText: 'Enter a body to email',
                      labelText: 'Body',
                    ),
                  ),
                ]),
          ),
        )
    );
  }
}