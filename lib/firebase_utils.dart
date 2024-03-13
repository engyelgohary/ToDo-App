import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/model/user.dart';
import 'model/task.dart';

class Firebaseutils {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.FromFirebase(snapshot.data()!)),
            toFirestore: (task, options) => task.tofirebase());
  }

  static Future<void> addTaskToFireStore(Task task, String uid) {
    var taskColllectionRefrence = getTaskCollection(uid);
    var taskDocref = taskColllectionRefrence.doc();
    task.id = taskDocref.id;
    return taskDocref.set(task);
  }

  static Future<void> deleteTask(Task task, String uid) {
    return getTaskCollection(uid).doc(task.id).delete();
  }

  static Future<void> updateTaskDoneStatus(Task task, bool isDone, String uid) {
    var taskDocRef = getTaskCollection(uid).doc(task.id);
    return taskDocRef.update({'isDone': isDone});
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.FromFirebase(snapshot.data()!)),
            toFirestore: (myuser, options) => myuser.tofirebase());
  }

  static Future<void> addUserToFireStore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String uid) async {
    var querySnapshot = await getUserCollection().doc(uid).get();
    return querySnapshot.data();
  }

  static Future<void> updateTask(Task task, String uid) {
    var taskDocRef = getTaskCollection(uid).doc(task.id);
    return taskDocRef.update(task.tofirebase());
  }
}
