import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  
  // Инициализация Remote Config
  static Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      
      // Устанавливаем значения по умолчанию
      await _remoteConfig.setDefaults({
        'show_update_dialog': false,
        'update_message': 'Вышла новая версия! Обновитесь, чтобы увидеть новый функционал.',
        'update_url': '',
        'force_update': false,
        'min_supported_version': '1.0.0',
        'maintenance_mode': false,
        'maintenance_message': 'Приложение временно недоступно. Ведутся технические работы.',
        'enable_new_features': true,
        'max_mixes_per_user': 50,
        'enable_social_features': true,
      });
      
      // Получаем и активируем конфигурацию
      await _remoteConfig.fetchAndActivate();
      
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка инициализации Remote Config: $e');
      }
    }
  }
  
  // Получение булевого значения
  static bool getBool(String key) {
    try {
      return _remoteConfig.getBool(key);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения bool значения для $key: $e');
      }
      return false;
    }
  }
  
  // Получение строкового значения
  static String getString(String key) {
    try {
      return _remoteConfig.getString(key);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения string значения для $key: $e');
      }
      return '';
    }
  }
  
  // Получение числового значения
  static int getInt(String key) {
    try {
      return _remoteConfig.getInt(key);
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка получения int значения для $key: $e');
      }
      return 0;
    }
  }
  
  // Проверка необходимости обновления
  static bool shouldShowUpdateDialog() {
    return getBool('show_update_dialog');
  }
  
  // Получение сообщения об обновлении
  static String getUpdateMessage() {
    return getString('update_message');
  }
  
  // Получение URL для обновления
  static String getUpdateUrl() {
    return getString('update_url');
  }
  
  // Проверка принудительного обновления
  static bool isForceUpdateRequired() {
    return getBool('force_update');
  }
  
  // Проверка режима обслуживания
  static bool isMaintenanceMode() {
    return getBool('maintenance_mode');
  }
  
  // Получение сообщения о техобслуживании
  static String getMaintenanceMessage() {
    return getString('maintenance_message');
  }
  
  // Проверка включения новых функций
  static bool areNewFeaturesEnabled() {
    return getBool('enable_new_features');
  }
  
  // Максимальное количество миксов на пользователя
  static int getMaxMixesPerUser() {
    return getInt('max_mixes_per_user');
  }
  
  // Проверка включения социальных функций
  static bool areSocialFeaturesEnabled() {
    return getBool('enable_social_features');
  }
  
  // Принудительное обновление конфигурации
  static Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка обновления Remote Config: $e');
      }
    }
  }
}