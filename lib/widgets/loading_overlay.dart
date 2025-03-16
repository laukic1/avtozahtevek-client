import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(BuildContext context) {
    if (!_isShowing) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Container(
          color: Colors.black.withOpacity(0.4), // ✅ Dim background
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );

      Future.delayed(Duration.zero, () {
        Overlay.of(context)?.insert(_overlayEntry!);
        _isShowing = true;
      });
    }
  }

  static void hide() {
    if (_isShowing && _overlayEntry != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        _overlayEntry?.remove();
        _overlayEntry = null; // ✅ Clear the reference
        _isShowing = false;
      });
    }
  }
}
