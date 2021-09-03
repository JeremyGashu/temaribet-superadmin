import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:temaribet/utils/utils.dart';

final CollectionReference _usersCollection =
    FirebaseFirestore.instance.collection('/users');

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<bool> userExists({String phoneNumber}) async {
  var userWithPhoneNumber =
      await _usersCollection.where('phone', isEqualTo: phoneNumber).get();
  return userWithPhoneNumber.docs.length > 0;
}

User getUser() {
  var user = _firebaseAuth.currentUser;
  return user;
}

Future<Role> getUserRoleByPhoneNumber({String phone}) async {
  var userInfo =
      await _usersCollection.where('phone', isEqualTo: phone).limit(1).get();
  if (userInfo.docs.length == 1) {
    if (userInfo.docs[0].data() is Map) {
      Map userInfoParsed = userInfo.docs[0].data() as Map;
      switch (userInfoParsed['role']) {
        case 'student':
          return Role.STUDENT;
        case 'parent':
          return Role.PARENT;
        case 'superadmin':
          return Role.SUPERADMIN;
        default:
          return Role.UNDEFINED;
      }
    }
  }
  return Role.UNDEFINED;
}
