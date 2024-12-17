import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_story_response_dto.dart';
import 'package:h3_14_bookie/presentation/location/location_provider.dart';
import 'package:h3_14_bookie/presentation/resources/app_images.dart';
import 'package:h3_14_bookie/presentation/widgets/widgets.dart';

class CustomMapInfoWidget extends StatefulWidget {
  const CustomMapInfoWidget({
    super.key,
    this.positions,
  });

  final List<ChapterStoryResponseDto>? positions;

  @override
  State<CustomMapInfoWidget> createState() => _CustomMapInfoWidgetState();
}

class _CustomMapInfoWidgetState extends State<CustomMapInfoWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late BitmapDescriptor iconOn;
  late BitmapDescriptor iconOff;
  late BitmapDescriptor iconPostion;
  Set<Marker> markers = {};
  final LocationProvider _locationService = LocationProvider();
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await fetchLocationUpdate());
  }

  Future<void> initData() async {
    setIconPosition();
    if (widget.positions != null) {
      await setIcon();
      setMarkers();
    }
  }

  Future<void> setIcon() async {
    iconOn = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(35, 40)), AppImages.iconMarkerOn);
    iconOff = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(35, 40)), AppImages.iconMarkerOn);
  }

  Future<void> setIconPosition() async {
    iconPostion = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(45, 45)), AppImages.iconStreetView);
  }

  void setMarkers() {
  bool flag = true;
  for (int i = 0; i < widget.positions!.length; i++) {
    final position = widget.positions![i];
    markers.add(
      Marker(
        onTap: () async {
          showCustomCardModal(context, position);
        },
        markerId: MarkerId(position.storyUid ?? 'marker_$i'), // Usar un ID único
        position: LatLng(position.latitude, position.longitude),
        icon: flag ? iconOn : iconOff,
      ),
    );
    flag = !flag;
  }
  setState(() {});
}


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: currentPosition == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            markers: {
              ...markers,
              Marker(
                markerId: const MarkerId('sourceLocation'),
                icon: iconPostion,
                position: currentPosition!,
              ),
            },
            mapType: MapType.normal,
            style:
                ''' [ { "featureType": "poi", "elementType": "labels", "stylers": [ { "visibility": "off" } ] }, { "featureType": "transit", "elementType": "labels", "stylers": [ { "visibility": "off" } ] } ] ''',
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
    );
  }

  Future<void> fetchLocationUpdate() async {
    final position = await _locationService.getCurrentLocation();
    if (position != null && mounted) {
      setState(() {
        currentPosition = position;
      });
    }
  }

  void showCustomCardModal(BuildContext context, ChapterStoryResponseDto chapterStory) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BookCardWidget(
              imageUrl: chapterStory.cover,
              title: chapterStory.title,
              synopsis: chapterStory.synopsis,
              categories: chapterStory.categories,
              rating: 4.2,
              reads: chapterStory.totalReadings,
              numberChapter: chapterStory.chapterNumber,
              placeChapterName: chapterStory.placeName,
              titleChapterName: chapterStory.chapterTitle,
              storyId: chapterStory.storyUid,
            ),
          ),
        );
      },
    );
  }
  
}
