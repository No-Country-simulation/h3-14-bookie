import 'package:flutter/material.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookItemWidget extends StatelessWidget {
  const BookItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8)
          ),
          width: 80,
          height: 100,
        ),
        title: const Text('Titulo del libro'),
        subtitle: const Column(
          children: [
            Text('Inicio de sinopsis del libro, una sinopsis larga para probar', maxLines: 2, overflow: TextOverflow.ellipsis,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(calification: 4),
                IconLabelWidget(label: '10K', icon: Icons.remove_red_eye_outlined)
              ],
            )
          ],
        ),
        trailing: Column(
          children: [
            GestureDetector(
              onTap: (){},
              child: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}