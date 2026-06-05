import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final firestore =
      FirebaseFirestore.instance;

  final auth =
      FirebaseAuth.instance;

  Future<void> saveStickers(
      List<dynamic> stickers) async {

    final user = auth.currentUser;

    if (user == null) return;

    final obtained = stickers

        .where((s) => s.obtained)

        .map((s) => s.number)

        .toList();

    await firestore
        .collection('users')
        .doc(user.uid)
        .set({

      'stickers': obtained,

      'updatedAt':
          FieldValue.serverTimestamp(),

    });
  }

  Future<List<int>> loadStickers()
      async {

    final user = auth.currentUser;

    if (user == null) return [];

    final doc =
        await firestore
            .collection('users')
            .doc(user.uid)
            .get();

    if (!doc.exists) return [];

    final data = doc.data();

    if (data == null) return [];

    return List<int>.from(
        data['stickers'] ?? []);
  }
}