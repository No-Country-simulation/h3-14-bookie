import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/entities/book_chapter_entity.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class SelectChapterDrawer extends StatelessWidget {
  const SelectChapterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.background,
        child: BorderLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Capítulos',
                style: textStyle.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<BookCreateBloc, BookCreateState>(
                  builder: (context, state) {
                    // Usamos directamente state.chapters
                    final chapters = state.chapters;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        final title = chapters[index].titleChapter;
                        final number = chapters[index].number;
                        return OutlinedButton(
                          onPressed: () {
                            // Acción al seleccionar un capítulo
                            context.read<BookCreateBloc>().add(ChangeChapterActive(number: number));
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: state.chapterActive.number == number ? AppColors.primaryColor : null,
                            foregroundColor: state.chapterActive.number == number ? AppColors.background : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Capítulo ${index + 1}: ${title.isEmpty ? '(Sin nombre)' : title}',
                            ),
                          ),
                        );
                      },
                      itemCount: chapters.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
