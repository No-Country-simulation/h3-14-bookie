import 'package:flutter/material.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

enum FilterBook {all, drafts, publications}

class EditView extends StatelessWidget {
  const EditView({super.key});

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
                Text('Mis historias', 
                  style: textStyle.titleLarge!.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: SegmentedButton<FilterBook>(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)))
                    ),
                    segments: const <ButtonSegment<FilterBook>>[
                      ButtonSegment(
                        value: FilterBook.all,
                        label: Text('Todas'),
                      ),
                      ButtonSegment(
                        value: FilterBook.drafts,
                        label: Text('Borradores'),
                      ),
                      ButtonSegment(
                        value: FilterBook.publications,
                        label: Text('Publicaciones'),
                      ),
                    ],
                    selected: const {FilterBook.all},
                    onSelectionChanged: (newSelection) {
                      // setState(() {
                      //   selectedValue = newSelection.first;
                      // });
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return const BookItemWidget();
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemCount: targets.length
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
