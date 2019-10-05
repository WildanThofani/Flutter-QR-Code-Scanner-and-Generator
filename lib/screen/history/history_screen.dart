import 'package:barcode_numbawan/bloc/note_bloc.dart';
import 'package:barcode_numbawan/models/model.dart';
import 'package:flutter/material.dart';

//void main() => runApp(History());
//
//class History extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'History',
//      darkTheme: ThemeData.dark(),
//      home: MyStatefulWidget(),
//    );
//  }
//}

class MyStatefulWidget extends StatefulWidget {

  final NoteBloc bloc;
  MyStatefulWidget(this.bloc);

//
//  MyStatefulWidget(this.bloc);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    super.initState();
    widget.bloc.inSink.add(Note(state: NotesState.GETALL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
        title: new Text('History'), backgroundColor: Colors.lightBlueAccent),
    body: Center(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: widget.bloc.outgoing,
              builder: (context, AsyncSnapshot<List<Note>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView(
                  children: snapshot.data
                      .map(
                        (note) => GestureDetector(
                      child: ListTile(
                        title: note.editing
                            ? TextFormField(
                          initialValue: note.body,
                          onFieldSubmitted: (text) => setState(
                                () => widget.bloc.inSink.add(
                              note.copyWith(
                                body: text,
                                editing: !note.editing,
                                state: NotesState.UPDATE,
                              ),
                            ),
                          ),
                        )
                            : Text(note.body),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => setState(
                                () => widget.bloc.inSink.add(
                              note.copyWith(
                                id: note.id,
                                state: NotesState.DETLETE,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() => widget.bloc.inSink.add(
                          note.copyWith(
                              editing: !note.editing,
                              state: NotesState.UPDATE),
                        ));
                        print(note.body);
                      },
                    ),
                  )
                      .toList(),
                );

              },
            ),
          ),
          MaterialButton(
            child: Text('Delete All'),
            onPressed: () => setState(() => widget.bloc.inSink.add(Note(
              state: NotesState.DELETE_ALL,
            ))),
            elevation: 10.0,
            color: Colors.lightBlueAccent,
          )
        ],
      ),
    ),
    );
  }
}
