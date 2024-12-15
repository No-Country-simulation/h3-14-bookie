import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/location/location_provider.dart';
import 'package:h3_14_bookie/presentation/widgets/dialogs/confirmation_dialog.dart';
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
  late TextEditingController _titleController;
  late TextEditingController _placeController;

  bool blockContent = true;

  @override
  void initState() {
    super.initState();

    final bookCreateBloc = context.read<BookCreateBloc>();
    final initialChapter = bookCreateBloc.state.chapterActive;

    _textController = TextEditingController();
    _titleController = TextEditingController(text: initialChapter.titleChapter);
    _placeController = TextEditingController(text: initialChapter.placeName);

    _titleController.addListener(() {
      bookCreateBloc.add(UpdateChapterActive(
        chapter: bookCreateBloc.state.chapterActive.copyWith(
          titleChapter: _titleController.text,
        )
      ));
    });

    _placeController.addListener(() {
      bookCreateBloc.add(UpdateChapterActive(
        chapter: bookCreateBloc.state.chapterActive.copyWith(
          placeName: _placeController.text,
        )
      ));
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final bookCreateBloc = context.read<BookCreateBloc>();


    bool validate(){
      if(_titleController.text.isEmpty || _placeController.text.isEmpty){
        Fluttertoast.showToast(msg: 'El título y nombre de la ubicación, son obligatorios.',
        backgroundColor: Colors.red);
        return false;
      }
      if(blockContent){
        Fluttertoast.showToast(msg: 'Es obligatorio elegir una ubicación.',
        backgroundColor: Colors.red);
        return false;
      }
      if(_textController.text.isEmpty){
        Fluttertoast.showToast(msg: 'Es obligatorio tener una historia.',
        backgroundColor: Colors.red);
        return false;
      }
      return true;
    }

    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            if(!validate()){
              return;
            }
            bookCreateBloc.add(CreateStoryEvent(whenComplete: (){
                context.read<EditViewBloc>().add(const GetStories()); //todo: verificar si se actualia la lsita al dar atras
                context.go('/home/3');
            }));
          }, icon: const Icon(Icons.save_outlined)),
          IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
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
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          ConfirmationDialog.show(
            context,
            question: '¿Estás seguro de que deseas salir sin guardar?',
            message: 'Tu historia no se ha guardado. Si decides irte sin guardar, perderás todos los cambios realizados.',
            confirmText: 'Guardar',
            cancelText: 'No guardar',
            onConfirm: () {
              if(validate()){
                bookCreateBloc.add(CreateStoryEvent(
                  whenComplete: (){
                    context.read<EditViewBloc>().add(const GetStories()); //todo: verificar si se actualia la lsita al dar atras
                    context.go('/home/3');
                  }));
              }
              return;
            },
            onCancel: (){
              context.go('/home/3');
            }
          );
            
          
          // bookCreateBloc.add(SaveChapterActive(
          //   chapter: bookCreateBloc.state.chapterActive.copyWith(
          //   placeName: _placeController.text,
          //   titleChapter: _titleController.text,
          // )));
          // bookCreateBloc.add(const CreateChapterEvent());
          // Fluttertoast.showToast(msg: 'Cambios guardados.');
        },
        child: BorderLayout(
          child: BlocListener<BookCreateBloc, BookCreateState>(
            listener: (context, state) {
              final chapter = state.chapterActive;
              _titleController.text = chapter.titleChapter;
              _placeController.text = chapter.placeName;
            },
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
                                  'Capítulo ${state.chapterActive.number}: ',
                                  style: textStyle.titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      hintText: 'Título del capítulo',
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                    CustomMapInfoWidget(),
                                    if (blockContent)
                                      GestureDetector(
                                        onTap: () async {
                                          final locationService =
                                              LocationProvider();
                                          final currentPosition =
                                              await locationService
                                                  .getCurrentLocation();
                                          if (currentPosition != null) {
                                            bookCreateBloc.add(UpdateChapterActive(
                                                chapter: state.chapterActive
                                                    .copyWith(
                                                        position:
                                                            currentPosition)));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Falla al obtener la ubicación actual');
                                          }
                                          setState(() {
                                            blockContent = false;
                                          });
                                        },
                                        child: const BlockContent(
                                            factorHeight: 0.4,
                                            message:
                                                'Diríjase a la ubicación elegida para este capítulo. Presiona aquí para utilizar el GPS y asignar la ubicación'),
                                      ),
                                    if (!blockContent)
                                      Positioned(
                                        right: 2,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              blockContent = true;
                                            });
                                            bookCreateBloc.add(
                                                UpdateChapterActive(
                                                    chapter: state.chapterActive
                                                        .copyWith(
                                                            position: null)));
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.background,
                                          ),
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      AppColors.primaryColor)),
                                        ),
                                      )
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
                                    controller: _placeController,
                                    decoration: InputDecoration(
                                      hintText: 'Nombre de la ubicación',
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                _textController.text = state
                                    .chapterActive.pages[state.currentPage];
                              },
                              child: Stack(
                                children: [
                                  TextFormField(
                                    maxLines: 10,
                                    controller: _textController,
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
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.background
                                      ),
                                      child: Text('${state.currentPage + 1}')),
                                  )
                                ],
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
                      activeLabels: true,
                      addingAction: () {
                        if(!validate()){
                          return;
                        }
                        bookCreateBloc.add(UpdateChapterActive(
                            chapter: state.chapterActive.copyWith(
                                pages: [...state.chapterActive.pages, '']),
                            whenComplete: () {
                              bookCreateBloc.add(UpdateCurrentPage(
                                  page: state.currentPage + 1));
                            }));
                      },
                      changePage: (page) {
                        bookCreateBloc.add(UpdateCurrentPage(page: page));
                      },
                      thirdOption: true,
                      thirdOptionAction: () async {
                        if(!validate()){
                          return;
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        // bookCreateBloc.add(SaveChapterActive(
                        //     chapter: bookCreateBloc.state.chapterActive.copyWith(
                        //       placeName: _placeController.text,
                        //       titleChapter: _titleController.text,
                        //     )));
                        bookCreateBloc.add(const AddChapterEvent());
                        setState(() {
                          blockContent = true;
                          _textController.text = '';
                        });
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
