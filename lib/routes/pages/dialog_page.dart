import 'package:flutter/material.dart';

class DialogPage extends Page {
  final Widget child;

  const DialogPage({required this.child, super.key});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      builder: (_) => child,
      settings: this,
      
    );
  }
}