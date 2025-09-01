import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../core/services/auth_service.dart';
import '../core/services/firestore_service.dart';
import '../core/services/storage_service.dart';
import '../core/services/analytics_service.dart';
import '../core/services/remote_config_service.dart';

class TasteSmokeApp extends StatelessWidget {
  const TasteSmokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Сервисы Firebase
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        Provider<StorageService>(create: (_) => StorageService()),
        Provider<AnalyticsService>(create: (_) => AnalyticsService()),
        Provider<RemoteConfigService>(create: (_) => RemoteConfigService()),
      ],
      child: MaterialApp(
        title: 'TasteSmoke',
        theme: AppTheme.darkTheme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Показываем загрузочный экран пока проверяем авторизацию
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF323234),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD44271),
              ),
            ),
          );
        }
        
        // Проверяем авторизован ли пользователь и подтвержден ли email
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}