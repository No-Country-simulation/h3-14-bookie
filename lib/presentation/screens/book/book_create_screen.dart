import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookCreateScreen extends StatelessWidget {
  static const name = 'book-create';
  const BookCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const locations = [
      'Plaza de la prevalencia',
      'Café Torres',
      'Parque Versalles'
    ];
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
                child: Container(
                  width: size.width * 0.7,
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text('Inserte una foto de portada'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextForm(
                label: 'Título',
              ),
              const TextForm(
                label: 'Sinopsis',
                maxLines: 4,
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
              ButtonAddForm(
                onTap: (){},
                label: 'Lugares',
                message: 'Seleccionar ubicaciones en el mapa',
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Capítulos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              }),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () => {},
                      child: const Text('Guardar'),
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
  const TextForm({super.key, required this.label, this.maxLines});

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
        TextFormField(
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 3,
        )
      ],
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
