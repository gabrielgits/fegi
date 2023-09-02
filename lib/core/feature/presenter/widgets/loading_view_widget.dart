
import 'package:flutter/material.dart';

class LoadingViewWidget extends StatelessWidget {
  final String info;
  const LoadingViewWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(info), 
        ],
      ),
    );
  }
}