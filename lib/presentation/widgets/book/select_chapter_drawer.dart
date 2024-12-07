import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class SelectChapterDrawer extends StatelessWidget {
  const SelectChapterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final chapters = [
      'A',
      'B',
      'C',
      'D',
      'E'
    ];
    return Drawer(
      backgroundColor: AppColors.background,
        child: SafeArea(
          child: BorderLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text('Capítulos', style: textStyle.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemBuilder: (context, index) {
                      return OutlinedButton(
                        
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15)
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Capitulo ${index + 1}: ${chapters[index]}')),
                      );
                    },
                    itemCount: chapters.length,
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}