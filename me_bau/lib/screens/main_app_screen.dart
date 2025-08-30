import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'weekly_handbook_screen.dart';
import 'checklist_screen.dart';
import 'profile_screen.dart';
import '../activities/main_app_activity.dart';
import '../widgets/app_components.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/profile_viewmodel.dart';

// Abstract class for screen actions
abstract class ScreenActions {
  List<Widget> getActions(BuildContext context);
  String getTitle();
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  late HomeViewModel _homeViewModel;
  late ProfileViewModel _profileViewModel;

  // Screen configurations with their actions
  final List<ScreenActions> _screenConfigs = [
    HomeScreenActions(),
    HandbookScreenActions(),
    ChecklistScreenActions(),
    ProfileScreenActions(),
  ];

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel();
    _profileViewModel = ProfileViewModel();
    _screens.addAll([
      HomeScreen(onNavigateToTab: _changeTab, viewModel: _homeViewModel),
      const WeeklyHandbookScreen(initialWeek: 1),
      const ChecklistScreen(),
      ProfileScreen(homeViewModel: _homeViewModel, profileViewModel: _profileViewModel),
    ]);
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>.value(value: _homeViewModel),
        ChangeNotifierProvider<ProfileViewModel>.value(value: _profileViewModel),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: _screenConfigs[_currentIndex].getTitle(),
          actions: _screenConfigs[_currentIndex].getActions(context),
        ),
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _changeTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Cẩm Nang'),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Checklist',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hồ Sơ'),
          ],
        ),
      ),
    );
  }
}

// Action configurations for each screen
class HomeScreenActions implements ScreenActions {
  @override
  List<Widget> getActions(BuildContext context) {
    final activity = MainAppActivity(context);
    return [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => activity.openSettings(),
      ),
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => activity.openNotifications(),
      ),
    ];
  }

  @override
  String getTitle() => 'Trang Chủ';
}

class HandbookScreenActions implements ScreenActions {
  @override
  List<Widget> getActions(BuildContext context) {
    final activity = MainAppActivity(context);
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => activity.searchHandbook(),
      ),
      IconButton(
        icon: const Icon(Icons.bookmark),
        onPressed: () => activity.bookmarkCurrentWeek(),
      ),
      IconButton(
        icon: const Icon(Icons.share),
        onPressed: () => activity.shareInformation(),
      ),
    ];
  }

  @override
  String getTitle() => 'Cẩm Nang';
}

class ChecklistScreenActions implements ScreenActions {
  @override
  List<Widget> getActions(BuildContext context) {
    final activity = MainAppActivity(context);
    return [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => activity.addChecklistItem(),
      ),
      IconButton(
        icon: const Icon(Icons.sort),
        onPressed: () => activity.sortChecklist(),
      ),
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () => activity.filterChecklist(),
      ),
    ];
  }

  @override
  String getTitle() => 'Checklist';
}

class ProfileScreenActions implements ScreenActions {
  @override
  List<Widget> getActions(BuildContext context) {
    final activity = MainAppActivity(context);
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => activity.editProfile(),
      ),
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => activity.openNotificationSettings(),
      ),
      IconButton(
        icon: const Icon(Icons.help),
        onPressed: () => activity.openHelp(),
      ),
    ];
  }

  @override
  String getTitle() => 'Hồ Sơ';
}
