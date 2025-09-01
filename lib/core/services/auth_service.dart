import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Текущий пользователь
  User? get currentUser => _auth.currentUser;
  
  // Поток изменений авторизации
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Регистрация с email и паролем
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Отправляем письмо подтверждения
      await result.user?.sendEmailVerification();
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка регистрации: $e');
      }
      rethrow;
    }
  }
  
  // Вход с email и паролем
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка входа: $e');
      }
      rethrow;
    }
  }
  
  // Сброс пароля
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка сброса пароля: $e');
      }
      rethrow;
    }
  }
  
  // Повторная отправка письма подтверждения
  Future<void> resendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка отправки письма: $e');
      }
      rethrow;
    }
  }
  
  // Выход
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка выхода: $e');
      }
      rethrow;
    }
  }
  
  // Проверка подтверждения email
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;
  
  // Обновление данных пользователя
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }
}