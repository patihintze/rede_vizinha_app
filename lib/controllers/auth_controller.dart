import 'dart:convert';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fire = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;

  final RxBool loading = false.obs;

  Future<bool> _cepPertencePinheiros(String cep) async {
    final onlyNumbers = cep.replaceAll(RegExp(r'\D'), '');
    final uri = Uri.parse('https://viacep.com.br/ws/$onlyNumbers/json/');
    final resp = await http.get(uri).timeout(const Duration(seconds: 8));
    if (resp.statusCode != 200) return false;
    final data = json.decode(resp.body);
    if (data == null || data['erro'] == true) return false;
    final bairro = (data['bairro'] ?? '').toString().toLowerCase();
    final uf = (data['uf'] ?? '').toString().toUpperCase();
    return uf == 'SP' && bairro.contains('pinheiros');
  }

  Future<String?> signUp({
    required String name,
    required String birthDate,
    required String cpf,
    required String email,
    required String phone,
    required String cep,
    required String password,
  }) async {
    loading.value = true;
    try {
      final cepOk = await _cepPertencePinheiros(cep);
      if (!cepOk) {
        return 'CEP inválido para o bairro de Pinheiros';
      }

      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCred.user!.uid;
      await _fire.collection('users').doc(uid).set({
        'name': name,
        'birthDate': birthDate,
        'cpf': cpf,
        'email': email,
        'phone': phone,
        'cep': cep,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await userCred.user!.updateDisplayName(name);

      Get.offAllNamed('/home');
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Erro ao criar usuário';
    } catch (e) {
      return 'Erro: ${e.toString()}';
    } finally {
      loading.value = false;
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    loading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Erro ao efetuar login';
    } catch (e) {
      return 'Erro: ${e.toString()}';
    } finally {
      loading.value = false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/');
  }
}
