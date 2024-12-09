class ValidateUri {
  static bool isValidUri(String input) {
    try {
      final uri = Uri.tryParse(input);
      // Verifica si la URI tiene un esquema y una autoridad válidos
      return uri != null && uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false; // Si hay un error, la URI no es válida
    }
  }
}
