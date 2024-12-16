import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/navigation_view/navigation_view_bloc.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewBloc, NavigationViewState>(
      builder: (context, state) {
        return state.loading
          ? const Expanded(child: Center(child: CircularProgressIndicator(),))
          : CustomMapInfoWidget(
              positions: state.listChapterStory,
          // positions: [
          //   LatLng(-34.718215, -58.260557),
          //   LatLng(-34.625955, -58.462272),
          //   LatLng(-34.624675, -58.466049),
          //   LatLng(-34.625222, -58.467905),
          // ],
        );
      },
    );
  }
}
