import 'package:h3_14_bookie/config/get_it/locator.dart';
import 'package:h3_14_bookie/presentation/views/views.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    FavoritesView(),
    NavigationView(),
    EditView(),
    SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: locator<GlobalKey<ScaffoldState>>(),
      endDrawer: EndDrawerWidget.instance,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
