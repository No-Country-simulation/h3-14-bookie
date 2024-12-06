import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class BookReadScreen extends StatelessWidget {
  static const name = 'book-read-screen';
  const BookReadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final keyScaffold = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    final Completer<GoogleMapController> controller =
        Completer<GoogleMapController>();

    const CameraPosition kLake = CameraPosition(
        bearing: 0, target: LatLng(-34.625946, -58.463903), tilt: 0, zoom: 14);

    bool blockContent = false;

    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
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
      body: BorderLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Capítulo 1: El Vestíbulo de los Susurros',
                  style: textStyle.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
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
                        CustomMapWidget(postion: kLake, controller: controller),
                        if(blockContent)
                        const BlockContent(
                          factorHeight: 0.4,
                          message:
                              '¡Desbloquea este capítulo!\nPresiona aquí y sigue las indicaciones para llegar a la ubicación correcta.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconLabelWidget(
                  labelStyle: textStyle.titleMedium,
                  label: 'Próxima ubicación a 2km',
                  icon: Icons.place_outlined,
                  center: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    const SingleChildScrollView(
                      child: Text(
                        'La noche era más oscura de lo habitual cuando Valeria cruzó la verja de hierro que rodeaba la famosa Mansión de los Susurros. El viento helado parecía cargar una advertencia, pero ella lo ignoró, decidida a desentrañar los secretos de aquel lugar. La puerta principal, decorada con figuras grotescas, pasó con un chirrido que resonó en el vacío. El vestíbulo era imponente, con un gran candelabro cubierto de telarañas suspendido en el techo. Valeria avanzó despacio, su linterna iluminando las paredes adornadas con retratos antiguos cuyos ojos parecían seguirla. La atmósfera era densa, como si algo invisible la rodeara. Mientras grababa sus observaciones, el espejo del vestíbulo captó su atención. Era un objeto enorme, con un marco de madera tallada en formas retorcidas. Cuando se dirige la linterna hacia él, vio una figura oscura detrás de su reflejo. Se giró rápidamente, pero no había nadie.',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    if(blockContent)
                    BlockContent(
                      factorHeight: 0.4,
                      message:
                          'Esta historia aún no puede ser leída porque aun no se encuentra en la ubicación.',
                    ),
                  ],
                ),
              ],
            ),
            const BookNavigation()
          ],
        ),
      ),
    );
  }
}

class BlockContent extends StatelessWidget {
  final double factorHeight;
  final String message;
  const BlockContent({
    super.key,
    required this.factorHeight,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * factorHeight,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(
              child: SizedBox(
            width: double.infinity,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )),
        ),
      ),
    );
  }
}
