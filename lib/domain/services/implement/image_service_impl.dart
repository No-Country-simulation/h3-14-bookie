import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:h3_14_bookie/domain/services/image_service.dart';

class ImageServiceImpl implements IImageService {
  late final CloudinaryPublic _cloudinary;
  static const String MAIN_FOLDER = 'Cloudinary-React';
  late final String _cloudName;

  ImageServiceImpl() {
    _cloudName = 'dabgkc4zi';
    final uploadPreset = 'rp8iy6uf';
    _cloudinary = CloudinaryPublic(_cloudName, uploadPreset);
  }

  @override
  Future<String> uploadImage(String imagePath) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          folder: '$MAIN_FOLDER',
        ),
      );
      return response.secureUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Future<bool> deleteImage(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) return true;

      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final publicId = pathSegments[pathSegments.length - 1].split('.').first;

      // Por seguridad, la eliminación debería implementarse en el backend
      throw UnimplementedError(
          'Image deletion should be implemented in backend');
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  @override
  Future<String> updateImage(
      String oldImageUrl, String newImagePath, String folder) async {
    try {
      // Primero intentamos eliminar la imagen antigua
      await deleteImage(oldImageUrl);
      // Luego subimos la nueva imagen
      return await uploadImage(newImagePath);
    } catch (e) {
      throw Exception('Failed to update image: $e');
    }
  }

  @override
  Future<String?> getImageById(String publicId, String folder) async {
    try {
      final String fullPublicId = '$MAIN_FOLDER/$folder/$publicId';
      return 'https://res.cloudinary.com/$_cloudName/image/upload/$fullPublicId';
    } catch (e) {
      throw Exception('Failed to get image: $e');
    }
  }
}