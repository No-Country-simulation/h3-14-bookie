import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(AppImages.iconLogo, width: 30, height: 30,
              ),
              const SizedBox(width: 15,),
              const Expanded(child: SearchWidget()),
              const SizedBox(width: 10,),
              const Icon(Icons.notifications_outlined, size: 30,),
              user != null
              ? CircleAvatar(

                radius: 15,
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.background,
                child: Text('${user.email?[0].toUpperCase()}${user.email?[1].toUpperCase()}', style: TextStyle(fontSize: 14),),)
              : const Icon(Icons.account_circle_outlined, size: 30)
            ],
          ),
        ),
      ),
    );
  }
}