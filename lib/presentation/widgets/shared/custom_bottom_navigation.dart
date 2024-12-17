import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/favorite_view/favorite_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/navigation_view/navigation_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        context.read<HomeViewBloc>().add(const GetStoriesHome(filter: ''));
        break;
      case 1:
        context.go('/home/1');
        context.read<FavoriteViewBloc>().add(const InitFavoritesEvent());
        break;
      case 2:
        context.go('/home/2'); // Central button
        context.read<NavigationViewBloc>().add(const GetStoryChapterEvent());
        break;
      case 3:
        context.go('/home/3');
        break;
      case 4:
        context.go('/home/4');
        break;
      default:
        context.go('/home/0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 0,
            backgroundColor: AppColors.background,
            enableFeedback: false,
            currentIndex: currentIndex,
            elevation: 0,
            onTap: (value) => onItemTapped(context, value),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildBarItem(
                  imagePath: AppImages.iconHome,
                  isSelected: currentIndex == 0,
                  tooltip: 'Inicio'),
              _buildBarItem(
                  imagePath: AppImages.iconLibrary,
                  isSelected: currentIndex == 1,
                  tooltip: 'Favoritos'),
              _buildCentralItem(Icons.explore_outlined,
                  isSelected: currentIndex == 2, tooltip: 'Navegar'),
              _buildBarItem(
                  imagePath: AppImages.iconPencil,
                  isSelected: currentIndex == 3,
                  tooltip: 'Escribir'),
              _buildBarItem(
                  icon: Icons.menu,
                  isSelected: currentIndex == 4,
                  tooltip: 'Configuración'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem({
    IconData? icon,
    String? imagePath,
    required bool isSelected,
    required String tooltip,
  }) {
    const color = AppColors.primaryColor;
    return BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: isSelected ?color : Colors.black,
                size: 35,
              )
            else if (imagePath != null)
              Image.asset(
                imagePath,
                width: 35,
                height: 35,
                color: isSelected ?color : Colors.black,
              ),
            if (isSelected)
              Container(
                height: 2,
                width: 30,
                margin: const EdgeInsets.only(top: 2),
                color: AppColors.primaryColor,
              ),
          ],
        ),
        label: '',
        tooltip: tooltip);
  }

  BottomNavigationBarItem _buildCentralItem(IconData icon,
      {required bool isSelected, required String tooltip}) {
    return BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: AppColors.accentColor,
            size: 25,
          ),
        ),
        label: '',
        tooltip: tooltip);
  }
}
