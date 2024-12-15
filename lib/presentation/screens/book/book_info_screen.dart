import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/read_view/read_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookInfoScreen extends StatefulWidget {
  static const name = 'book-screen';
  final String bookId;
  const BookInfoScreen({super.key, required this.bookId});

  @override
  State<BookInfoScreen> createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  static const CameraPosition _kLake = CameraPosition(
      bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 0, zoom: 14);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    const locations = [
      'Plaza de la prevalencia',
      'Café Torres',
      'Parque Versalles'
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.book_outlined))
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
      body: FutureBuilder(
          future: StoryServiceImpl().getStoryById(widget.bookId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final story = snapshot.data;
            if (story == null) {
              return const Center(child: Text('No se encontró la historia'));
            }

            return SingleChildScrollView(
              child: BorderLayout(
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                          image: story.cover!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(story.cover!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      story.title ?? '',
                      style: textStyle.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.secondaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(story.authorUid!),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.schedule_outlined),
                            Text('30 min')
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sinopsis',
                              style: textStyle.titleMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              story.synopsis!,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StarRating(calification: story.rate!),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('${story.totalReadings} reads')
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.width * 0.5,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const InfoRouteMap(
                            centerOnUser: false,
                            positions: [
                              LatLng(37.40523168383278, -122.15067051351069),
                              LatLng(37.40209318936961, -122.14084122329949)
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const IconLabelWidget(
                      label: 'Próxima ubicación a 2km',
                      icon: Icons.place_outlined,
                      center: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Total capitulos: ${story.chaptersUid?.length} (solo es una marca)'),
                          const Text('Lugares'),
                          const SizedBox(
                            height: 10,
                          ),
                          ...locations.map((location) => IconLabelWidget(
                              label: location, icon: Icons.push_pin_outlined)),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Capítulos'),
                          const SizedBox(
                            height: 10,
                          ),
                          ...locations.asMap().entries.map((entry) {
                            int index = entry.key;
                            var location = entry.value;
                            return IconLabelWidget(
                              label: 'Capítulo ${index + 1}: $location',
                              icon: Icons.list,
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/home/0/book/1/read');
                          context
                              .read<ReadViewBloc>()
                              .add(ChangeStoryUidSelected(uid: widget.bookId));
                        },
                        child: const Text('Leer'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
