import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, User?>((ref) {

  return AuthNotifier();
});

class AuthNotifier
    extends StateNotifier<User?> {

  AuthNotifier() : super(null) {

    FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {

      state = user;
    });
  }

  Future<void> signInWithGoogle()
      async {

    final googleUser =
        await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final googleAuth =
        await googleUser.authentication;

    final credential =
        GoogleAuthProvider.credential(

      accessToken:
          googleAuth.accessToken,

      idToken:
          googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance
            .signInWithCredential(
                credential);

    state = userCredential.user;
  }

  Future<void> logout() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.clear();

  await GoogleSignIn().signOut();

  await FirebaseAuth.instance
      .signOut();

  state = null;
}
}