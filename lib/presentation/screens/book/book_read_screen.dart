import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/read_view/read_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookReadScreen extends StatelessWidget {
  static const name = 'book-read-screen';
  const BookReadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final keyScaffold = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;

    bool blockContent = false;

    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                keyScaffold.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.list))
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
        title: Text(context.read<ReadViewBloc>().state.story.title),
        centerTitle: true,
      ),
      endDrawer: const SelectChapterReadDrawer(),
      body: BorderLayout(child:
          BlocBuilder<ReadViewBloc, ReadViewState>(builder: (context, state) {
        if (state.story.chapters.isEmpty) {
          return const Center(child: Text('Esta historia no tiene capítulos'));
        }
        final chapter = state.chapterActive;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Capítulo 1: ${chapter.title}',
                  style: textStyle.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width * 0.9,
                  height: size.width * 0.5,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        InfoRouteMap(
                          centerOnUser: true,
                          positions: state.chapterList.map((c)=>LatLng(c.lat, c.long)).toList(),
                        ),
                        if (blockContent)
                          const BlockContent(
                            factorHeight: 0.4,
                            message:
                                '¡Desbloquea este capítulo!\nPresiona aquí y sigue las indicaciones para llegar a la ubicación correcta.',
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconLabelWidget(
                  labelStyle: textStyle.titleMedium,
                  label: 'Próxima ubicación a 2km',
                  icon: Icons.place_outlined,
                  center: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: size.height * 0.4,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Text(
                          chapter.pages[state.pageChapterSelected],
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      if (blockContent)
                        BlockContent(
                          factorHeight: 0.4,
                          message:
                              'Esta historia aún no puede ser leída porque aun no se encuentra en la ubicación.',
                        ),
                    ],
                  ),
                ),
              ],
            ),
            BookNavigation(
              currentPage: state.pageChapterSelected,
              totalPages: state.chapterActive.pages.length + 1,
              changePage: (currentPage) {
                if(currentPage == state.chapterActive.pages.length){
                  context.read<ReadViewBloc>().add(const ChangePageChapterSelected(page: 0));
                  context.push('/home/0/book/1/read/finish-read');
                  return;
                }
                context.read<ReadViewBloc>().add(ChangePageChapterSelected(page: currentPage));
              },
            )
          ],
        );
      })),
    );
  }
}
