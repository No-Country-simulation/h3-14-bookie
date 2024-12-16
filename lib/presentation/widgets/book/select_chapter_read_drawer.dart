import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/read_view/read_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class SelectChapterReadDrawer extends StatelessWidget {
  const SelectChapterReadDrawer({super.key});

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
                child: BlocBuilder<ReadViewBloc, ReadViewState>(
                  builder: (context, state) {
                    // Usamos directamente state.chapters
                    final chapters = state.chapterList;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        final chapter = chapters[index];
                        final title = chapter.title;
                        final chapterId = chapter.chapterUid;
                        return OutlinedButton(
                          onPressed: () {
                            // Acción al seleccionar un capítulo
                            context.read<ReadViewBloc>().add(ChangeChapterReadActive(storyId: chapterId!));
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: state.chapterActive.chapterUid == chapterId ? AppColors.primaryColor : null,
                            foregroundColor: state.chapterActive.chapterUid == chapterId ? AppColors.background : null,
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
