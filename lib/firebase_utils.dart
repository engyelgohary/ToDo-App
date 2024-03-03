import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task.dart';

class Firebaseutils {
  static CollectionReference<Task> getTaskCollection(){
   return FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore:((snapshot,options) => Task.FromFirebase(snapshot.data()!)),
        toFirestore: (task,options)=>task.tofirebase()
    );
  }
  static Future<void> addTaskToFireStore(Task task){
   var taskColllectionRefrence = getTaskCollection();
   var taskDocref = taskColllectionRefrence.doc();
   task.id =taskDocref.id;
   return taskDocref.set(task);
  }
}