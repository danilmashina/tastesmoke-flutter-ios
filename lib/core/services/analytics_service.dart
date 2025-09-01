import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: _analytics);
  
  // Логирование входа пользователя
  static Future<void> logLogin(String method) async {
    try {
      await _analytics.logLogin(loginMethod: method);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования входа: $e');
      }
    }
  }
  
  // Логирование регистрации
  static Future<void> logSignUp(String method) async {
    try {
      await _analytics.logSignUp(signUpMethod: method);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования регистрации: $e');
      }
    }
  }
  
  // Логирование создания микса
  static Future<void> logCreateMix(String mixType) async {
    try {
      await _analytics.logEvent(
        name: 'create_mix',
        parameters: {
          'mix_type': mixType,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования создания микса: $e');
      }
    }
  }
  
  // Логирование добавления в избранное
  static Future<void> logAddToFavorites(String mixId) async {
    try {
      await _analytics.logEvent(
        name: 'add_to_favorites',
        parameters: {
          'mix_id': mixId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования добавления в избранное: $e');
      }
    }
  }
  
  // Логирование лайка
  static Future<void> logLikeMix(String mixId) async {
    try {
      await _analytics.logEvent(
        name: 'like_mix',
        parameters: {
          'mix_id': mixId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования лайка: $e');
      }
    }
  }
  
  // Логирование просмотра экрана
  static Future<void> logScreenView(String screenName, String screenClass) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка логирования просмотра экрана: $e');
      }
    }
  }
  
  // Установка свойств пользователя
  static Future<void> setUserProperties({String? userId, String? userType}) async {
    try {
      if (userId != null) {
        await _analytics.setUserId(id: userId);
      }
      if (userType != null) {
        await _analytics.setUserProperty(name: 'user_type', value: userType);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка установки свойств пользователя: $e');
      }
    }
  }
}