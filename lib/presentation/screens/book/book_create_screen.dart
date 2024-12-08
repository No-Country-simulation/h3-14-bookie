import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
        title: const Text('Agregando Historia'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
        shadowColor: AppColors.primaryColor,
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
                            image: _image == null? null :DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: _image == null
                            ? const Text('Inserte una foto de portada')
                            : null,
                        ),
                      ),
                      if(_image != null)
                      Positioned(
                        top: 2,
                        right: 1,
                        child: IconButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.background
                            )
                          ),
                          onPressed: (){
                            setState(() {
                              _image = null;
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.primaryColor,)),
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
                      'Utiliza palabras clave para que el lecntor encunetre tu historia',
                  onTap: () {
                    context.go('/home/3/book-create/tags');
                  },
              ),
              ButtonAddForm(
                label: 'Categorías',
                message: 'Seleccione una o más categorias',
                onTap: () {
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
                  const Icon(Icons.push_pin_outlined, color: AppColors.primaryColor,),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: TextFormField(
                      controller: placeController,
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el nombre de la ubicación',
                        border: OutlineInputBorder(),
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
                  const SizedBox(width: 20,),
                  Expanded(
                    child: TextFormField(
                      controller: chapterController,
                      decoration: const InputDecoration(
                        hintText: 'Título del capítulo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        bookCreateBloc.add(CreateStoryEvent(
                          story: StoryDto(
                            title: titleController.text,
                            synopsis: synopsisController.text,
                            categoriesUid: bookCreateBloc.state.categories.where((c)=>c.isActive).map((c)=>c.uid).toList(),
                            labels: bookCreateBloc.state.targets
                          )
                        ));
                        bookCreateBloc.add(
                          AddInitialChapterEvent(
                            title: chapterController.text,
                            placeName: placeController.text
                          )
                        );
                        context.push('/home/3/book-create/chapter-edit');
                      },
                      child: const Text('Guardar y Continuar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
  const TextForm({super.key, required this.label, this.maxLines, required this.hintText, required this.controller});

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
            hintText: hintText,
            border: const OutlineInputBorder(),
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
  const ButtonAddForm(
      {super.key, required this.label, required this.message, required this.onTap});

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
          onPressed: ()=>onTap(),
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
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
