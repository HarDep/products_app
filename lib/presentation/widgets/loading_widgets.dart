import 'package:flutter/material.dart';

class ListLoader extends StatelessWidget {
  final Widget content;
  final bool loadCondition;
  const ListLoader({super.key, required this.content, required this.loadCondition});

  @override
  Widget build(BuildContext context) {
    return loadCondition? content : const ListLoading();
  }
}

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
