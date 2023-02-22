import 'package:flutter/material.dart';

class BuildBoxContent extends StatelessWidget {
  const BuildBoxContent(
      {Key? key, required this.title, required this.value, required this.color, required this.isLoading})
      : super(key: key);

  final String title, value;
  final Color color;
  final bool isLoading;

  //  mostSellingItems.isEmpty ? const Text('No data available') :
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5)),
        child: isLoading ? const Center(child: SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5,))) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.isEmpty ? '0.0' : value.padLeft(2, '0'),
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 5),
            Text(
              title.toUpperCase(),
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}