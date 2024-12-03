import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/get_it/locator.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const targets = ['A','B','C','D'];
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        const CustomAppbar(),
        Expanded(
          child: BorderLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Historias cerca', style: textStyle.titleLarge,),
                    IconButton(onPressed: (){
                      EndDrawerWidget.instance.body = const CategoriesDrawer();
                      locator<GlobalKey<ScaffoldState>>().currentState!.openEndDrawer();
                    }, icon: const Icon(Icons.sort))
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.only(top: 10),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: targets.length,
                    itemBuilder: (context, index) {
                      bool isSecondColumn = index % 2 == 1;
                      return Transform.translate(
                        offset: Offset(0, isSecondColumn ? 20.0 : 0.0),
                        child: InkWell(
                          onTap: () => context.push('/home/0/book/${ targets[index] }'),
                          child: const BookWidget()
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
