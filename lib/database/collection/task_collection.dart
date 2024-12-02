import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/dataBase/model/task.dart';

class TaskCollection {
  CollectionReference<Task> getTasksCollection(userId) {
    var db = FirebaseFirestore.instance;
    return db.collection('users').doc(userId).collection('tasks').withConverter(
      fromFirestore: (snapshot, options) {
        return Task.fromFirestor(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
  }

  Future<void> createTask(String userId, Task task) {
    var docRef = getTasksCollection(userId).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  Future<List<Task>> getAllTasks(String userId, int selectedDate) async {
    QuerySnapshot<Task> querySnapshot = await getTasksCollection(userId)
        .where('date', isEqualTo: selectedDate)
        .orderBy('time', descending: false)
        .get();
    List<Task> tasksList = querySnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
        )
        .toList();
    return tasksList;
  }

  Stream<QuerySnapshot<Task>> listenForTask(
      String userId, int selectedDate) async* {
    yield* getTasksCollection(userId)
        .where('date', isEqualTo: selectedDate)
        .orderBy('time', descending: false)
        .snapshots();
  }

  Future<void> removeTask(String userId, Task task) {
    var docRef = getTasksCollection(userId).doc(task.id).delete();
    return docRef;
  }
}
