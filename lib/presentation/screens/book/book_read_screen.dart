import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
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

    const CameraPosition kLake = CameraPosition(
        bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 0, zoom: 14);

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
      ),
      endDrawer: const SelectChapterDrawer(),
      body: BorderLayout(
        child: BlocBuilder<ReadViewBloc, ReadViewState>(
          builder: (context, state) {
            return FutureBuilder(
                future: Future.value().then((_) async {
                    final chapterUid = await ChapterServiceImpl()
                        .getChapterUidByStoryUidAndChapterNumber(
                          state.storyId,
                          state.pageChapterSelected
                        );
                    if (chapterUid.isEmpty) throw Exception('No se encontró el capítulo');
                    
                    return await ChapterServiceImpl().getChapterById(chapterUid);
                  }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final chapter = snapshot.data;
                  if (chapter == null) {
                    return const Center(
                        child: Text('No se encontró el capítulo'));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Capítulo 1: El Vestíbulo de los Susurros',
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
                                const SingleChildScrollView(
                                  child: Text(
                                    'La noche era más oscura de lo habitual cuando Valeria cruzó la verja de hierro que rodeaba la famosa Mansión de los Susurros. El viento helado parecía cargar una advertencia, pero ella lo ignoró, decidida a desentrañar los secretos de aquel lugar. La puerta principal, decorada con figuras grotescas, pasó con un chirrido que resonó en el vacío. El vestíbulo era imponente, con un gran candelabro cubierto de telarañas suspendido en el techo. Valeria avanzó despacio, su linterna iluminando las paredes adornadas con retratos antiguos cuyos ojos parecían seguirla. La atmósfera era densa, como si algo invisible la rodeara. Mientras grababa sus observaciones, el espejo del vestíbulo captó su atención. Era un objeto enorme, con un marco de madera tallada en formas retorcidas. Cuando se dirige la linterna hacia él, vio una figura oscura detrás de su reflejo. Se giró rápidamente, pero no había nadie.',
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
                        currentPage: 10,
                        totalPages: 50,
                        changePage: (currentPage) {},
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
