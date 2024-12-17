import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/helpers/validate_uri.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

enum BookItemMenuEnum { unposting, posting, edit, delete }

class BookItemWidget extends StatelessWidget {
  final String id;
  final bool isDraft;
  final String title;
  final String synopsis;
  final double rate;
  final int readings;
  final String cover;
  const BookItemWidget(
      {super.key,
      this.isDraft = false,
      required this.id,
      required this.title,
      required this.cover,
      required this.synopsis,
      required this.rate,
      required this.readings});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDraft ? Colors.grey[300] : AppColors.background,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 5, top: 8, bottom: 8),
        child: Row(
          children: [
            // Imagen con bordes redondeados
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 80,
                child: ValidateUri.isValidUri(cover)
                    ? Image.network(
                        cover,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      )
                    : Container(color: Colors.grey),
              ),
            ),
            
            SizedBox(width: 12),
            
            // Contenido
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    synopsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      StarRating(calification: rate),
                      SizedBox(width: 8),
                      IconLabelWidget(
                        label: '${readings}K',
                        icon: Icons.remove_red_eye_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menú de tres puntos separado
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<BookItemMenuEnum>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  padding: EdgeInsets.zero,
                  onSelected: (BookItemMenuEnum item) {
                    if (BookItemMenuEnum.unposting == item ||
                        BookItemMenuEnum.posting == item) {
                      context.read<EditViewBloc>().add(ChangeStatusBook(
                          writing: Writing(isDraft: !isDraft, storyId: id),
                       ));
                    }
                    if(BookItemMenuEnum.delete == item) {
                      context.read<EditViewBloc>().add(DeleteCreateBook(id: id));
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<BookItemMenuEnum>>[
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
          ],
        ),
      ),
    );
  }
}
