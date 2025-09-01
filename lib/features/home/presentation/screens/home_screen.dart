import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView('home', 'HomeScreen');
  }
  
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Логируем переключение вкладок
    String screenName = _getScreenName(index);
    AnalyticsService.logScreenView(screenName, 'BottomNavigation');
  }
  
  String _getScreenName(int index) {
    switch (index) {
      case 0:
        return 'home';
      case 1:
        return 'categories';
      case 2:
        return 'favorites';
      case 3:
        return 'profile';
      default:
        return 'unknown';
    }
  }
  
  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildCategoriesPage();
      case 2:
        return _buildFavoritesPage();
      case 3:
        return _buildProfilePage();
      default:
        return _buildHomePage();
    }
  }
  
  Widget _buildHomePage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 64,
            color: AppTheme.accentPink,
          ),
          SizedBox(height: 16),
          Text(
            'Добро пожаловать в TasteSmoke!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Здесь будут ваши миксы и популярный контент',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoriesPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category,
            size: 64,
            color: AppTheme.accentPink,
          ),
          SizedBox(height: 16),
          Text(
            'Категории',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Здесь будут категории миксов',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFavoritesPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 64,
            color: AppTheme.accentPink,
          ),
          SizedBox(height: 16),
          Text(
            'Избранное',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Здесь будут ваши избранные миксы',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfilePage() {
    final user = FirebaseAuth.instance.currentUser;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.accentPink,
              child: Icon(
                Icons.person,
                size: 50,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.email ?? 'Неизвестный пользователь',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            if (user?.emailVerified == true)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Email подтвержден',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
      ),
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.accentPink,
        unselectedItemColor: AppTheme.secondaryText,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Категории',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
  
  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'TasteSmoke';
      case 1:
        return 'Категории';
      case 2:
        return 'Избранное';
      case 3:
        return 'Профиль';
      default:
        return 'TasteSmoke';
    }
  }
}