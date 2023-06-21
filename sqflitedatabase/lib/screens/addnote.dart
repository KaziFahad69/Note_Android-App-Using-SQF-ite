import 'package:flutter/material.dart';
import 'package:sqflitedatabase/models/notemodel.dart';
import 'package:sqflitedatabase/services/db_helper.dart';

class AddNote extends StatefulWidget {
  final Note ?note;
  final int ?index;
  AddNote({super.key,this.note, this.index});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
    TextEditingController ?titleController;
    TextEditingController?descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController!.dispose();
    descriptionController!.dispose();
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
                "Enter new Task!!",
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
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                //autofocus: true,
                maxLines: 3,
                controller: descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if(titleController!.text !='') {
                        DbHelper.addNote(Note(title: titleController!.text, description: descriptionController!.text));
                      }
                  Navigator.pop(context);

                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Save",
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
