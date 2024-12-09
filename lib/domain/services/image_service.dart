abstract class IImageService {
  /// Uploads an image to Cloudinary in the specified folder
  Future<String> uploadImage(String imagePath);
  /// Deletes an image from Cloudinary using its URL
  Future<bool> deleteImage(String imageUrl);
  /// Updates an existing image with a new one
  Future<String> updateImage(
      String oldImageUrl, String newImagePath, String folder);
  /// Gets the image URL by its public ID
  Future<String?> getImageById(String publicId, String folder);
}