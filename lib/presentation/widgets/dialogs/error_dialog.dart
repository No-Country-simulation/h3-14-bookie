import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const ErrorDialog({
    super.key,
    this.title = 'Lo sentimos',
    this.message =
        'No hemos podido encontrar un registro de usuario con el correo electrónico ingresado.',
    this.onRetry,
  });

  static void show(BuildContext context,
      {String? message, VoidCallback? onRetry}) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        message: message ??
            'No hemos podido encontrar un registro de usuario con el correo electrónico ingresado.',
        onRetry: onRetry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006494),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onRetry?.call();
                  },
                  child: const Text('Intentar de nuevo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
