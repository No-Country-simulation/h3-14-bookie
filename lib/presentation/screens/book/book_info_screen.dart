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

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.book_outlined))
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: StoryServiceImpl().getHomeStoryDtoByStoryUid(widget.bookId),
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
                          borderRadius: BorderRadius.circular(15)),
                      child: story.cover != null && story.cover!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                story.cover!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.secondaryColor,
                                    child: const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.book_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
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
                            Text(story.authorName),
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
                          child: InfoRouteMap(
                            centerOnUser: false,
                            positions: [
                              ...story.chapters
                                  .map((c) => LatLng(c.lat, c.long))
                              // LatLng(37.40523168383278, -122.15067051351069),
                              // LatLng(37.40209318936961, -122.14084122329949)
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
                          const Text('Lugares'),
                          const SizedBox(
                            height: 10,
                          ),
                          ...story.chapters.map((location) => IconLabelWidget(
                              label: location.placeName,
                              icon: Icons.push_pin_outlined)),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Capítulos'),
                          const SizedBox(
                            height: 10,
                          ),
                          ...story.chapters.asMap().entries.map((entry) {
                            int index = entry.key;
                            var title = entry.value.title;
                            return IconLabelWidget(
                              label: 'Capítulo ${index + 1}: $title',
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
                          context
                              .read<ReadViewBloc>()
                              .add(ChangeStoryUidSelected(story: story));

                          context
                              .read<ReadViewBloc>()
                              .add(AddNewReadingEvent(storyId: widget.bookId));

                          Future.delayed(const Duration(milliseconds: 100), () {
                            context.push('/home/0/book/1/read');
                          });
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
