import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engage/core/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // notifies whenever a user logs in or logs out
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogleWeb() => signInWithGoogle();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential? userCredential;
      if(kIsWeb){
        userCredential =
            await _auth.signInWithPopup(GoogleAuthProvider());
      }else{
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize(); 

        final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

          userCredential = await _auth.signInWithCredential(credential);
      }

      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection(AppConstants.usersCollection).doc(user.uid).set({
          'uid': user.uid,
          'fullName': user.displayName ?? 'Unknown Organiser',
          'email': user.email ?? '',
          'photoUrl': user.photoURL ?? '',
          'role': 'organiser',
          'lastLogin': FieldValue.serverTimestamp(),
          'eventsRegisteredCount': 0,
        }, SetOptions(merge: true));
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      // 1. If on mobile, sign out of Google SDK so the account picker shows next time
      if (!kIsWeb) {
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize();

        await googleSignIn.signOut();
      }

      // 2. Sign out of Firebase Auth (works for both Web and Mobile)
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }
}