import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> updateUserDetails(String firstName, String lastName, String contactNumber) async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await _firestore.collection("Users").doc(currentUser.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'contactNo': contactNumber,
      });
    }
  }

  Future<void> updateUserProfileImage(String profileImageUrl) async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      await _firestore.collection('users').doc(userId).update({
        'profileImageUrl': profileImageUrl,
      });
      print('Profile image URL updated successfully');
    } catch (e) {
      print('Error updating profile image URL: $e');
    }
  }

}
