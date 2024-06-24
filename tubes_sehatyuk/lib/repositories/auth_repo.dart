import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something wrong!';
    } catch (e) {
      throw e;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'displayName': name,
          'phoneNumber': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong!';
    } catch (e) {
      throw e;
    }
  }
}
