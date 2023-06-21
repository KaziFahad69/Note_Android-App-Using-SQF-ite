import 'package:flutter/material.dart';
import 'package:sqflitedatabase/models/notemodel.dart';
import 'package:sqflitedatabase/services/db_helper.dart';

// ignore: must_be_immutable
class UpdateNote extends StatefulWidget {
   Note ?note;
   int? index; 
   UpdateNote({super.key,required this.note, required this.index});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

@override
  void initState() {
    // TODO: implement initState
  _titleController = TextEditingController(text: widget.note!.title);
   _descriptionController = TextEditingController(text: widget.note!.description);
    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    _titleController!.dispose();
    _descriptionController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Edit Task",
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  child: Image.asset('images/todo.jpg')),
              TextField(
                //autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: TextField(
                  //autofocus: true,
                  maxLines: 3,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Description'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Note update = Note(title: _titleController!.text, description: _descriptionController!.text,id: widget.index);
                      DbHelper.updateNote(update);
                  Navigator.pop(context);
                  setState(() {
                    
                  });
                  
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}