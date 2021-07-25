import 'package:flutter/material.dart';

void showToastEmail(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Enter a valid email!'),
    ),
  );
}

void showToastPassword(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Password should contain at least 6 characters.'),
    ),
  );
}

void showToastName(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Enter your name!'),
    ),
  );
}

void showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Invalid credentials!'),
    ),
  );
}
