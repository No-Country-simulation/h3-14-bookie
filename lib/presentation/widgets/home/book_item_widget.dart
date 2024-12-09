import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

enum BookItemMenuEnum { unposting, posting, edit, delete }

class BookItemWidget extends StatelessWidget {
  final bool isDraft;
  const BookItemWidget({super.key, this.isDraft = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: isDraft ? AppColors.secondaryColor : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
          width: 80,
          height: 100,
        ),
        title: const Text('Titulo del libro'),
        subtitle: const Column(
          children: [
            Text(
              'Inicio de sinopsis del libro, una sinopsis larga para probar',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(calification: 4),
                IconLabelWidget(
                    label: '10K', icon: Icons.remove_red_eye_outlined)
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton<BookItemMenuEnum>(
              color: Colors.white,
              splashRadius: 25,
              // shape: BeveledRectangleBorder(
              //   borderRadius: BorderRadius.circular(10)
              // ),
              onSelected: (BookItemMenuEnum item) {
                
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<BookItemMenuEnum>>[
                if(!isDraft)
                const PopupMenuItem<BookItemMenuEnum>(
                  value: BookItemMenuEnum.unposting,
                  child: Text('Pausar publicación'),
                ),
                if(isDraft)
                const PopupMenuItem<BookItemMenuEnum>(
                  value: BookItemMenuEnum.posting,
                  child: Text('Publicar borrador'),
                ),
                const PopupMenuItem<BookItemMenuEnum>(
                  value: BookItemMenuEnum.edit,
                  child: Text('Editar información'),
                ),
                const PopupMenuItem<BookItemMenuEnum>(
                  value: BookItemMenuEnum.delete,
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
