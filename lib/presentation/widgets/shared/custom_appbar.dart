import 'package:flutter/material.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(AppImages.iconLogo),
              const SizedBox(width: 10,),
              const Expanded(child: SearchWidget()),
              const Icon(Icons.notifications_outlined, size: 30,),
              const Icon(Icons.account_circle_outlined, size: 30)
            ],
          ),
        ),
      ),
    );
  }
}