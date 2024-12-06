import 'package:flutter/material.dart';
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
        child: SafeArea(
          child: BorderLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text('Capítulos', style: textStyle.titleLarge,),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemBuilder: (context, index) {
                      return OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20.0)
                        ),
                        child: Text('Capitulo ${index + 1}: ${chapters[index]}'),
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