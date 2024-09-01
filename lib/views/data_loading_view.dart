import 'package:flutter/material.dart';

class DataLoadingView extends StatelessWidget {
  const DataLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: const LinearProgressIndicator(),
      ),
    );
  }
}
