import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/dataBase/model/app_user.dart';

class UserCollection {
  CollectionReference<AppUser> getUsersCollection() {
    var db = FirebaseFirestore.instance;
    return db.collection('users').withConverter(
      fromFirestore: (snapshot, options) {
        return AppUser.fromFirestore(snapshot.data());
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
  }

  Future<void> createUser(AppUser user) {
    return getUsersCollection().doc(user.authId).set(user);
  }

  Future<AppUser?> readUser(String uid) async {
    var doc = getUsersCollection().doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}
