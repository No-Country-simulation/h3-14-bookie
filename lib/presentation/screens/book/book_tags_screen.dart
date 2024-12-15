import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookTagsScreen extends StatelessWidget {
  static const String name = 'book-tags';
  const BookTagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w500, color: AppColors.background);
    return Scaffold(
      appBar: const CustomTitleAppbar(title: 'Etiquetas'),
      body: BorderLayout(
        child: Column(
          children: [
            const Text(
              'Utiliza palabras claves para que el lector encuentre tu historia.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.tag),
                hintText: 'Escriba una etiqueta...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<BookCreateBloc>().add(AddTargetEvent(target: textController.text));
                  textController.text = '';
                },
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)))),
                child: Text(
                  'Añadir Etiqueta',
                  style: textStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<BookCreateBloc, BookCreateState>(
                builder: (context, state) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                      itemCount: state.targets.length,
                      itemBuilder: (context, index) {
                        final tag = state.targets[index];
                        return _CustomChip(
                          label: tag,
                          onDelete: () {
                            context.read<BookCreateBloc>().add(DeleteTargetEvent(index: index));
                          },
                        );
                      },),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;
  const _CustomChip({
    required this.label,
    required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '#$label',
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
