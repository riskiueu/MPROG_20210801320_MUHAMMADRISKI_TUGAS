import 'package:flutter/material.dart';

class GridViewLearning extends StatelessWidget {
  const GridViewLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(30),
      itemCount: 8,  // Jumlah item dalam grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // Jumlah kolom
        childAspectRatio: 2 / 2,  // Rasio anak widget di dalam grid
        crossAxisSpacing: 10,  // Jarak antar kolom
        mainAxisSpacing: 10,  // Jarak antar baris
      ),
      itemBuilder: (ctx, i) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text('Item $i')), 
        );
      },
    );
  }
}
