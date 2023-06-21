// ignore_for_file: empty_statements

import 'package:flutter/material.dart';
import 'package:sqflitedatabase/models/notemodel.dart';
import 'package:sqflitedatabase/screens/addnote.dart';
import 'package:sqflitedatabase/screens/updatenote.dart';
import 'package:sqflitedatabase/services/db_helper.dart';

class HomePage extends StatefulWidget {
  final Note? note;
  const HomePage({super.key, this.note});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
leading:  Builder(
    builder: (context) {
      return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          // open the drawer
          Scaffold.of(context).openDrawer();
        },
      );
    },
    ),

        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Note", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
              
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(90))
              ),
              child: Center(child: Text("User"))
            ,),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Name", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),),
                Text("Other Things", style: TextStyle(fontSize: 14, color: Colors.white,),)

              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
        ),
      ),
      ListTile(
        title: Text('Get out'),
        onTap: () {
          // do something
        },
      ),
      ListTile(
        title: Text('Log out 😂kidding just exit the app'),
        onTap: () {
          // do something
        },
      ),
    ],
    ),
  ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddNote()))
                .then((value) {
              setState(() {});
            });
          }),
      //backgroundColor: Colors.lightBlueAccent,
      body: FutureBuilder<List<Note>?>(
        future: DbHelper.getAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10,),
                
                itemCount: snapshot.data!.length,
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              reverse: true,
              
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                   return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(2),
                      //height: MediaQuery.of(context).size.height*.2,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                        
                      ),
                        child: ListTile(
                        title: Text(data.title!, style: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold
                        ),),
                        subtitle: Text(
                          data.description!, style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: GestureDetector(
                          onTap: (){
                            showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
    title: Text('You really want to delete this?'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
      TextButton(
        onPressed: () {
         DbHelper.deleteNote(data);
         setState(() {
           
         });
         Navigator.pop(context);
        },
        child: Text('Delete'),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.red,
        ),
      ),
    ],
    );
  },
);

                          },
                          child: Icon(Icons.delete,color: Colors.white54,)),

                        trailing: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateNote(
                              note: Note(description: data.description, title: data.title,),
                             index: data.id
                             ))).then((value) {
                              setState(() {
                                
                              });
                             });
                          },
                          child: Icon(Icons.edit,color: Colors.white54,)),
                       
                      
                        ),
                        
                        
                      );
                     // print(data.title);
                  }
                  
                  
                      );
            }
            //Error Occurs
            setState(() {});
          }
          //Error Occur
          return Center(
              child: Text(
            'No Task Added Yet',
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ));
        },
      ),
    );
  }
}
