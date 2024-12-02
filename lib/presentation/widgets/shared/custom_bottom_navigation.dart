import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
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
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2'); // Central button
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          selectedFontSize: 0,
          backgroundColor: AppColors.secondaryColor,
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
    );
  }

  BottomNavigationBarItem _buildBarItem({
    IconData? icon,
    String? imagePath,
    required bool isSelected,
    required String tooltip,
  }) {
    final color = isSelected ? AppColors.primaryColor : AppColors.background;
    return BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color,
                size: 30,
              )
            else if (imagePath != null)
              Image.asset(
                imagePath,
                width: 30,
                height: 30,
                color: color,
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
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: AppColors.accentColor,
            size: 35,
          ),
        ),
        label: '',
        tooltip: tooltip);
  }
}
