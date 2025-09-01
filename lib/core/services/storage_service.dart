import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // Загрузка изображения профиля
  Future<String?> uploadProfileImage(String userId, File imageFile) async {
    try {
      // Создаем уникальное имя файла
      String fileName = 'profile_$userId.jpg';
      
      // Ссылка на место хранения
      Reference ref = _storage.ref().child('profile_images').child(fileName);
      
      // Загружаем файл
      UploadTask uploadTask = ref.putFile(imageFile);
      
      // Ждем завершения загрузки
      TaskSnapshot snapshot = await uploadTask;
      
      // Получаем URL для скачивания
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка загрузки изображения: $e');
      }
      rethrow;
    }
  }
  
  // Загрузка изображения микса
  Future<String?> uploadMixImage(String mixId, File imageFile) async {
    try {
      String fileName = 'mix_${mixId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      Reference ref = _storage.ref().child('mix_images').child(fileName);
      
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      
      String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка загрузки изображения микса: $e');
      }
      rethrow;
    }
  }
  
  // Удаление файла
  Future<void> deleteFile(String filePath) async {
    try {
      Reference ref = _storage.ref().child(filePath);
      await ref.delete();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка удаления файла: $e');
      }
      rethrow;
    }
  }
  
  // Получение URL для загрузки
  Future<String> getDownloadUrl(String filePath) async {
    try {
      Reference ref = _storage.ref().child(filePath);
      return await ref.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения URL: $e');
      }
      rethrow;
    }
  }
}