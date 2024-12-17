import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/config/helpers/enums/book_enum.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Mis historias',
          style: textStyle.titleLarge!.copyWith(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 0,
        ),
        BlocBuilder<EditViewBloc, EditViewState>(
          builder: (context, state) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<EditViewBloc>().add(const ChangeFilter(filter: FilterBook.all));
                  },
                  child: Container(
                    height: 47,
                    width: width / 3,
                    decoration: BoxDecoration(
                        color: state.filterSelected == FilterBook.all
                          ?const Color(0xFFFCFE6F1)
                          :AppColors.background,
                        borderRadius:
                            const BorderRadius.only(bottomLeft: Radius.circular(14)),
                        border: Border.all(width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: const Center(child: Text('Todas')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<EditViewBloc>().add(const ChangeFilter(filter: FilterBook.drafts));
                  },
                  child: Container(
                    height: 47,
                    width: width / 3,
                    decoration: BoxDecoration(
                        color: state.filterSelected == FilterBook.drafts
                          ?const Color(0xFFFCFE6F1)
                          :AppColors.background,
                        border:
                            const Border.symmetric(horizontal: BorderSide(width: 0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: const Center(child: Text('Borradores')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<EditViewBloc>().add(const ChangeFilter(filter: FilterBook.publications));
                  },
                  child: Container(
                    height: 47,
                    width: width / 3,
                    decoration: BoxDecoration(
                        color: state.filterSelected == FilterBook.publications
                          ?const Color(0xFFFCFE6F1)
                          :AppColors.background,
                        borderRadius:
                            const BorderRadius.only(bottomRight: Radius.circular(14)),
                        border: Border.all(width: 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: const Center(child: Text('Publicaciones')),
                  ),
                )
              ],
            );
          },
        ),
        Expanded(
          child: BorderLayout(
            child: Column(
              children: [
                // BlocBuilder<EditViewBloc, EditViewState>(
                //   builder: (context, state) {
                //     return SegmentedButton<FilterBook>(
                //       selectedIcon: null,
                //       showSelectedIcon: false,
                //       style: ButtonStyle(
                //           shape: WidgetStatePropertyAll(
                //               ContinuousRectangleBorder(
                //                   borderRadius: BorderRadius.circular(16)))),
                //       segments: const <ButtonSegment<FilterBook>>[
                //         ButtonSegment(
                //           value: FilterBook.all,
                //           label: Text(
                //             'Todas',
                //           ),
                //         ),
                //         ButtonSegment(
                //           value: FilterBook.drafts,
                //           label: Text('Borradores'),
                //         ),
                //         ButtonSegment(
                //           value: FilterBook.publications,
                //           label: Text('Publicaciones'),
                //         ),
                //       ],
                //       selected: {state.filterSelected},
                //       onSelectionChanged: (newSelection) {
                //         context
                //             .read<EditViewBloc>()
                //             .add(ChangeFilter(filter: newSelection.first));
                //       },
                //     );
                //   },
                // ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<EditViewBloc, EditViewState>(
                    builder: (context, state) {
                      return state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state.stories.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Aún no tienes historias. ¡Empieza ahora!\nToca el botón + para crear tu primera historia.',
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    final response = state.stories[index];
                                    final info = response.story;
                                    return BookItemWidget(
                                      id: info.storyUid,
                                      title: info.title,
                                      isDraft: response.isDraft,
                                      synopsis: info.synopsis,
                                      rate: info.rate,
                                      readings: info.readings,
                                      cover: info.cover,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: state.stories.length);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
