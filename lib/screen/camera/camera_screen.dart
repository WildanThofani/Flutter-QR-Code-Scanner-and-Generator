import 'dart:ui';

import 'package:barcode_numbawan/bloc/note_bloc.dart';
import 'package:barcode_numbawan/bloc/provider.dart';
import 'package:barcode_numbawan/models/model.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';

class Camera extends StatefulWidget {

  final NoteBloc bloc;

  Camera(this.bloc);

//  Camera({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Camera> {
  List<String> data = [];

  String _dataScan = "";

  NoteBloc bloc;

  void coba(context) async {
    final barcode = await Navigator.of(context).push<Barcode>(
      MaterialPageRoute(
        builder: (c) {
          return ScanPage(bloc);

        },
      ),
    );
    if (null == barcode) {
      return;
    }

      data.add(barcode.rawValue);
    data.map((value)=> _dataScan = (value)).toList();
      _dataScan = data as String;
    data.map((value) => _dataScan = (value)).toList();

//      data.map((value) => _dataScan = value = _data);
//      data.map((value) => _dataScan = value);
      String text = _dataScan;


//    onSaved: (value) => _dataStringOrganization = value,

      widget.bloc.inSink
          .add(Note(body: text, state: NotesState.INSERT));
       print(text);
       print("text = ${text}");
    print("dataScan = ${_dataScan}");
       print("data = ${data}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      coba(context);
//      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
//  Path data;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Barcode"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: ListView(
              children: data.map((item) => new Text(item)).toList(),

//              onSaved: (value) => _dataStringJobTitle = value,
//            children: data.map((value) => _dataScan = (value)).toList(),

            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
      backgroundColor: Colors.white,
    );
  }
}



class ScanPage extends StatefulWidget {
  final NoteBloc bloc;

  ScanPage(this.bloc);
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool resultSent = false;
  List<String> data = [];

  String _dataScan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CameraMlVision<List<Barcode>>(
            overlayBuilder: (c) {
              return Container(
                decoration: ShapeDecoration(
                  shape: _ScannerOverlayShape(
                    borderColor: Theme.of(context).primaryColor,
                    borderWidth: 3.0,
                  ),
                ),
              );
            },
            detector: FirebaseVision.instance.barcodeDetector().detectInImage,
            onResult: (List<Barcode> barcodes) {
              if (!mounted || resultSent) {
                return;
              }

//              setState(() {
//                 (value) => _dataScan = value;
//              });




              Navigator.of(context).pop<Barcode>(barcodes.first);
              print("@@@ barcode=" + barcodes.first.rawValue);
              print(resultSent = true);
              data.add(barcodes.first.rawValue);
//              data.map((value) => _dataScan = value);
//              onSaved: (value) => _dataStringPhone = value,
              data.map((item) => new Text(item)).toList();
              print("coba : ${barcodes}");


              data.map((value) => _dataScan = (value)).toList();
              _dataScan = data as String;


//      data.map((value) => _dataScan = value = _data);
//      data.map((value) => _dataScan = value);
              String text = _dataScan;


//    onSaved: (value) => _dataStringOrganization = value,

              widget.bloc.inSink
                  .add(Note(body: text, state: NotesState.INSERT));
              print(text);
              print("text = ${text}");
              print("dataScan = ${_dataScan}");
              print("data = ${data}");


            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  _ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x88000000),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    const lineSize = 30;

    final width = rect.width;
    final borderWidthSize = width * 10 / 100;
    final height = rect.height;
    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right,
            rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height,
            rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
            rect.right - borderSize.width,
            rect.top + borderSize.height,
            rect.right,
            rect.bottom - borderSize.height),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        borderSize.width + borderOffset,
        borderSize.height + borderOffset + rect.top,
        width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

    //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

    //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

    //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
