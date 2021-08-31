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

Future initUserWithPhoneAndRole({String phone, String role}) async {
  print('init user called with phone => $phone and role => $role');
  bool registered = await userExists(phoneNumber: phone);
  if(!registered) {
    print('the user is not registered => registering now');
    await _usersCollection.add({'phone': phone, 'role': role});
  }
  else{
    print('the user is already initialized');
  }
  
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
        default:
          return Role.UNDEFINED;
      }
    }
  }
  return Role.UNDEFINED;
}
