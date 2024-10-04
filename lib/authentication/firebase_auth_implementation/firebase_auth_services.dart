import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithUserCredentials (String email, String password) async {


    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some Error Occurred");
    }

    return null;

  }


  Future<User?> loginWithUserCredentials (String email, String password) async {

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some Error Occurred");
    }

    return null;

  }


  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserDetails() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {

      DocumentSnapshot userSnapshot = await _firestore.collection("Users").doc(currentUser.uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      }
    }
    return null;
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);

    await user.updatePassword(newPassword);
  }
}


