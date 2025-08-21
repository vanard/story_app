import 'package:flutter/material.dart';

class BottomSheetPage extends Page {
  final Widget child;

  const BottomSheetPage({required this.child, super.key});

  @override
  Route createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      builder: (_) => child,
      isScrollControlled: true,
      settings: this,
    );
  }
}
