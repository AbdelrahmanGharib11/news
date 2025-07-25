import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  ErrorIndicator({super.key, this.message});
  String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message == null ? 'Fetching Data Failed' : message!,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
