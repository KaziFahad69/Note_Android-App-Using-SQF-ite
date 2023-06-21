class Note{
  int ?id;
  String ? title;
  String ? description;

  Note({this.id, this.title, this.description});

  // Creates a Note instance from a Map
  factory Note.fromJson(Map<String, dynamic> json) =>Note(
    id: json['id'], 
    title: json['title'], 
    description: json['description']);


  // Converts a Note instance into a Map
  Map<String,dynamic> toJson()=>{
    'id': id,
    'title': title,
    'description':description,
    
  };


}