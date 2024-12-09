import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/helpers/validate_uri.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

enum BookItemMenuEnum { unposting, posting, edit, delete }

class BookItemWidget extends StatelessWidget {
  final bool isDraft;
  final String title;
  final String synopsis;
  final int rate;
  final int readings;
  final String cover;
  const BookItemWidget(
      {super.key,
      this.isDraft = false,
      required this.title,
      required this.cover,
      required this.synopsis,
      required this.rate,
      required this.readings});

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
          child: ValidateUri.isValidUri(cover)
              ? Image.network(
                  cover,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : null,
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              synopsis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(calification: rate),
                IconLabelWidget(
                    label: '$readings', icon: Icons.remove_red_eye_outlined)
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
              onSelected: (BookItemMenuEnum item) {},
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<BookItemMenuEnum>>[
                if (!isDraft)
                  const PopupMenuItem<BookItemMenuEnum>(
                    value: BookItemMenuEnum.unposting,
                    child: Text('Pausar publicación'),
                  ),
                if (isDraft)
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
