import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Sign up
  Future<String> singUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoURL = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoURL: photoURL,
        );

        await _firebaseFirestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      }
      if (err.code == 'weak-password') {
        res = 'Password should be stronger.';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // loggin user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }

    // on FirebaseAuthException catch(e){
    //   if(e.code == 'user-not-found'){

    //   }
    //   if(e.code == 'wrong-password'){

    //   }
    // }

    catch (e) {
      res = e.toString();
    }
    return res;
  }
}
