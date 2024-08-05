// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context, {
  required String message,
}) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
