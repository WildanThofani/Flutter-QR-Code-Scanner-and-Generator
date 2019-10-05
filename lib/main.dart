import 'package:barcode_numbawan/screen/camera/cam_screen.dart';
import 'package:barcode_numbawan/screen/camera/camera_screen.dart';
import 'package:barcode_numbawan/screen/generate/generate_screen.dart';
import 'package:barcode_numbawan/screen/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:barcode_numbawan/bloc/note_bloc.dart';
import 'package:barcode_numbawan/bloc/provider.dart';

import 'package:barcode_numbawan/models/model.dart';
import 'package:barcode_numbawan/database/crud.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      builder: (_, NoteBloc bloc) =>
          bloc ??
          NoteBloc(
            DBLogic(),
          ),
      onDispose: (_, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barcode Numbawan',
//      home: MyHomePage(),
        home: BottomNavBar(),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _page = 0;

  final _pageOption = [
    GenerateScreen(bloc),
    Camera(bloc),
    MyStatefulWidget(bloc),
  ];

  static NoteBloc bloc;



 

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NoteBloc>(context);
    final _pageOption = [
      GenerateScreen(bloc),
      Camera(bloc),
      MyStatefulWidget(bloc),
    ];


    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.camera_alt, size: 30),
          Icon(Icons.history, size: 30),
        ],
        color: Colors.lightBlueAccent,
        buttonBackgroundColor: Colors.lightBlueAccent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 350),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}

