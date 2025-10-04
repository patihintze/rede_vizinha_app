import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class NeighborsController extends GetxController {
  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  Stream<List<UserModel>> get usersStream {
    return _fire
        .collection('users')
        .orderBy('name')
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => UserModel.fromMap(d.id, d.data())).toList(),
        );
  }

  List<UserModel> filterByName(List<UserModel> list, String query) {
    if (query.trim().isEmpty) return list;
    final q = query.toLowerCase();
    return list.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  Future<void> removeUser(String uid) async {
    await _fire.collection('users').doc(uid).delete();
  }
}
