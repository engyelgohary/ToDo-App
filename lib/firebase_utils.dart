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

  static Future<void> deleteTask(Task task){
    return getTaskCollection().doc(task.id).delete();
  }
   static Future<void> updateTask(Task task) async { 
      await getTaskCollection().doc(task.id).update(task.tofirebase());
  }
   static Future<void> updateTaskDoneStatus(Task task, bool isDone) {
    var taskDocRef = getTaskCollection().doc(task.id);
    return taskDocRef.update({'isDone': isDone});
  }
}