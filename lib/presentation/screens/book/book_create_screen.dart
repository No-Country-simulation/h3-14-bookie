import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:h3_14_bookie/config/helpers/enums/book_enum.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';

class BookCreateScreen extends StatefulWidget {
  static const name = 'book-create';
  const BookCreateScreen({super.key});

  @override
  State<BookCreateScreen> createState() => _BookCreateScreenState();
}

class _BookCreateScreenState extends State<BookCreateScreen> {
  final titleController = TextEditingController();
  final synopsisController = TextEditingController();
  final placeController = TextEditingController();
  final chapterController = TextEditingController();
  File? _image;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookCreateBloc = context.read<BookCreateBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Información'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BorderLayout(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                            image: _image == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: _image == null
                              ? const Text('Inserte una foto de portada')
                              : null,
                        ),
                      ),
                      if (_image != null)
                        Positioned(
                          top: 2,
                          right: 1,
                          child: IconButton(
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.background)),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColors.primaryColor,
                              )),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextForm(
                label: 'Título',
                hintText: 'Ingrese el título de la historia',
                controller: titleController,
              ),
              TextForm(
                label: 'Sinopsis',
                maxLines: 4,
                hintText: 'Haz una descripción de la historia',
                controller: synopsisController,
              ),
              ButtonAddForm(
                label: 'Etiquetas',
                message:
                    'Utiliza palabras clave para que el lector encuentre tu historia',
                selectedItems: context.watch<BookCreateBloc>().state.targets,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.go('/home/3/book-create/tags');
                },
              ),
              ButtonAddForm(
                label: 'Categorías',
                message: 'Seleccione una o más categorias',
                selectedItems: context
                    .watch<BookCreateBloc>()
                    .state
                    .categories
                    .where((c) => c.isActive)
                    .map((c) => c.name)
                    .toList(),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.go('/home/3/book-create/categories');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelForm(label: 'Lugares'),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.push_pin_outlined,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: placeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Ingrese el nombre de la ubicación',
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
                height: 10,
              ),
              const LabelForm(label: 'Capítulos'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const IconLabelWidget(label: 'Capítulo 1', icon: Icons.list),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chapterController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Título del capítulo',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_image == null) {
                          Fluttertoast.showToast(
                              msg: 'Es obligatorio subir una portada.',
                              backgroundColor: Colors.red);
                          return;
                        }
                        if (titleController.text.isEmpty ||
                            synopsisController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'El Título y la Sinopsis son obligatorios.',
                              backgroundColor: Colors.red);
                          return;
                        }
                        if (bookCreateBloc.state.categories.isEmpty ||
                            bookCreateBloc.state.targets.isEmpty) {
                          Fluttertoast.showToast(
                              msg:
                                  'Debes agregar almenos una etiqueta y una categoría.',
                              backgroundColor: Colors.red);
                          return;
                        }
                        if (chapterController.text.isEmpty ||
                            placeController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg:
                                  'El título y nombre de la ubicación, son obligatorios.',
                              backgroundColor: Colors.red);
                          return;
                        }
                        bookCreateBloc.add(SaveStoryEvent(
                            titleBook: titleController.text,
                            synopsisBook: synopsisController.text,
                            pathImage: _image!.path,
                            titleChapter: chapterController.text,
                            placeName: placeController.text));

                        // Esperamos a que se guarde el estado
                        await Future.delayed(const Duration(milliseconds: 100));
                        context.push(
                            '/home/3/book-create/chapter-edit'); // Creamos la historia
                        // bookCreateBloc.add(CreateStoryEvent(whenComplete: () {
                        //   // Navegamos a la pantalla de edición de capítulos
                        //   context.push('/home/3/book-create/chapter-edit');
                        // }
                        // ))
                        ;
                      },
                      child: const Text('Continuar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final String label;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const TextForm(
      {super.key,
      required this.label,
      this.maxLines,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelForm(label: label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        )
      ],
    );
  }
}

class LabelForm extends StatelessWidget {
  const LabelForm({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ButtonAddForm extends StatelessWidget {
  final String label;
  final String message;
  final Function onTap;
  final List<String>? selectedItems;
  const ButtonAddForm({
    super.key,
    required this.label,
    required this.message,
    required this.onTap,
    this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        OutlinedButton(
          onPressed: () => onTap(),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: selectedItems != null && selectedItems!.isNotEmpty
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: selectedItems!
                          .map((item) => Chip(
                                label: Text(item),
                                backgroundColor: Colors.grey[200],
                              ))
                          .toList(),
                    )
                  : Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
        ),
        const SizedBox(
          height: 3,
        )
      ],
    );
  }
}
