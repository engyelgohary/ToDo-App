// ignore_for_file: non_constant_identifier_names

class Task {
  static const String collectionName = 'Taska';
  String? id;
  String? title;
  String? description;
  DateTime? time;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.time,
      this.isDone = false});
// opp to json
  Map<String, dynamic> tofirebase() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

//json to oop
  Task.FromFirebase(Map<String, dynamic> data)
      : this(
          id: data['id'],
          description: data['description'],
          title: data['title'],
          time: DateTime.fromMillisecondsSinceEpoch(data['time']),
          isDone: data['isDone'],
        );
}
