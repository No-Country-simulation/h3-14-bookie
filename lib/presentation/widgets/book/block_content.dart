import 'dart:ui';

import 'package:flutter/material.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
