import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class ChapterEditScreen extends StatefulWidget {
  static const name = 'chapter-edit-screen';
  const ChapterEditScreen({super.key});

  @override
  State<ChapterEditScreen> createState() => _ChapterEditScreenState();
}

class _ChapterEditScreenState extends State<ChapterEditScreen> {
  final keyScaffold = GlobalKey<ScaffoldState>();

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final bookCreateBloc = context.read<BookCreateBloc>();
    final Completer<GoogleMapController> controller =
        Completer<GoogleMapController>();
    final CameraPosition kLake = const CameraPosition(
        bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 0, zoom: 14);

    bool blockContent = true;

    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
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
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
        },
        child: BorderLayout(
          child: BlocBuilder<BookCreateBloc, BookCreateState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Capítulo 1: ',
                                style: textStyle.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue:
                                      state.chapterActive.titleChapter,
                                  decoration: InputDecoration(
                                    hintText: 'Título del capítulo',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                  CustomMapWidget(
                                      postion: kLake, controller: controller),
                                  if (blockContent)
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          blockContent = false;
                                        });
                                      },
                                      child: Container(
                                        color: AppColors.secondaryColor,
                                        width: double.infinity,
                                        height: 250,
                                        child: const Center(child: Text('Diríjase a la ubicación elegida para este capítulo. Presiona aquí para utilizar el GPS y asignar la ubicación', textAlign: TextAlign.center,)),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.place_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: state.chapterActive.placeName,
                                  decoration: InputDecoration(
                                    hintText: 'Nombre de la ubicación',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BlocListener<BookCreateBloc, BookCreateState>(
                            listener: (context, state) {
                              _textController.text =
                                  state.chapterActive.pages[state.currentPage];
                            },
                            child: TextFormField(
                              maxLines: 10,
                              controller: _textController,
                              // initialValue: state.chapterActive.pages[state.currentPage],
                              onChanged: (value) {
                                List<String> list =
                                    List.from(state.chapterActive.pages);
                                list[state.currentPage] = value;
                                bookCreateBloc.add(UpdateChapterActive(
                                    chapter: state.chapterActive
                                        .copyWith(pages: list)));
                              },
                              decoration: InputDecoration(
                                hintText: 'Comienza a escribir una historia',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  BookNavigation(
                    totalPages: state.chapterActive.pages.length,
                    currentPage: state.currentPage,
                    adding: true,
                    addingAction: () {
                      bookCreateBloc.add(UpdateChapterActive(
                          chapter: state.chapterActive.copyWith(
                              pages: [...state.chapterActive.pages, '']),
                          whenComplete: () {
                            bookCreateBloc.add(
                                UpdateCurrentPage(page: state.currentPage + 1));
                          }));
                    },
                    changePage: (page) {
                      bookCreateBloc.add(UpdateCurrentPage(page: page));
                    },
                    thirdOption: true,
                    thirdOptionAction: () async {
                      bookCreateBloc.add(SaveChapterActive(
                          chapter: bookCreateBloc.state.chapterActive));
                      // await Future.delayed(Duration(seconds: 1));
                      bookCreateBloc.add(const AddChapterEvent());
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
