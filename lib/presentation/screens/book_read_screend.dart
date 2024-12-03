import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class BookReadScreend extends StatelessWidget {
  static const name = 'book-read-screen';
  const BookReadScreend({super.key});
  @override
  Widget build(BuildContext context) {
    final keyScaffold = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
                      keyScaffold.currentState!.openEndDrawer();
          }, icon: const Icon(Icons.list))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primaryColor,
            height: 1.0,
          )
        ),
        shadowColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Text('Capitulos')
          ],
        ),
      ),
    );
  }
}