import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/helpers/enums/book_enum.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    const targets = ['A', 'B', 'C', 'D'];
    final textStyle = Theme.of(context).textTheme;
    return BorderLayout(
      child: Column(
        children: [
          Text(
            'Mis historias',
            style: textStyle.titleLarge!.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<EditViewBloc, EditViewState>(
            builder: (context, state) {
              return SegmentedButton<FilterBook>(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(16)))),
                segments: const <ButtonSegment<FilterBook>>[
                  ButtonSegment(
                    value: FilterBook.all,
                    label: Text('Todas'),
                  ),
                  ButtonSegment(
                    value: FilterBook.drafts,
                    label: Text('Borradores'),
                  ),
                  ButtonSegment(
                    value: FilterBook.publications,
                    label: Text('Publicaciones'),
                  ),
                ],
                selected: {state.filterSelected},
                onSelectionChanged: (newSelection) {
                  context
                      .read<EditViewBloc>()
                      .add(ChangeFilter(filter: newSelection.first));
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<EditViewBloc, EditViewState>(
              builder: (context, state) {
                return state.isLoading
                ? const Center(child: CircularProgressIndicator(),)
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final response = state.stories[index];
                      final info = response.story;
                      return BookItemWidget(
                        title: info.title,
                        isDraft: response.isDraft,
                        synopsis: info.synopsis,
                        rate: info.rate,
                        readings: info.readings,
                        cover: info.cover,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: state.stories.length);
              },
            ),
          )
        ],
      ),
    );
  }
}
