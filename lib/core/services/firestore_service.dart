import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Коллекции
  static const String usersCollection = 'users';
  static const String mixesCollection = 'mixes';
  static const String favoritesCollection = 'favorites';
  static const String likesCollection = 'likes';
  
  // Создание/обновление пользователя
  Future<void> createOrUpdateUser(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection(usersCollection).doc(userId).set(
        userData,
        SetOptions(merge: true),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка создания пользователя: $e');
      }
      rethrow;
    }
  }
  
  // Получение данных пользователя
  Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      return await _firestore.collection(usersCollection).doc(userId).get();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения данных пользователя: $e');
      }
      rethrow;
    }
  }
  
  // Поток данных пользователя
  Stream<DocumentSnapshot> getUserDataStream(String userId) {
    return _firestore.collection(usersCollection).doc(userId).snapshots();
  }
  
  // Создание микса
  Future<DocumentReference> createMix(Map<String, dynamic> mixData) async {
    try {
      return await _firestore.collection(mixesCollection).add(mixData);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка создания микса: $e');
      }
      rethrow;
    }
  }
  
  // Получение миксов пользователя
  Stream<QuerySnapshot> getUserMixes(String userId) {
    return _firestore
        .collection(mixesCollection)
        .where('authorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
  
  // Получение популярных миксов
  Stream<QuerySnapshot> getPopularMixes({int limit = 20}) {
    return _firestore
        .collection(mixesCollection)
        .where('isPublic', isEqualTo: true)
        .orderBy('likesCount', descending: true)
        .limit(limit)
        .snapshots();
  }
  
  // Добавление в избранное
  Future<void> addToFavorites(String userId, String mixId) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(favoritesCollection)
          .doc(mixId)
          .set({
        'mixId': mixId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка добавления в избранное: $e');
      }
      rethrow;
    }
  }
  
  // Удаление из избранного
  Future<void> removeFromFavorites(String userId, String mixId) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(userId)
          .collection(favoritesCollection)
          .doc(mixId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка удаления из избранного: $e');
      }
      rethrow;
    }
  }
  
  // Получение избранного
  Stream<QuerySnapshot> getFavorites(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .collection(favoritesCollection)
        .orderBy('addedAt', descending: true)
        .snapshots();
  }
}