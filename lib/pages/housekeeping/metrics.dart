import 'package:flutter/material.dart';

class HouseKeepingMetricsPage extends StatelessWidget {
  const HouseKeepingMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My metrics'),
        centerTitle: true,
      ),
      body: const Center(child: Text('Work in progress!')
          // GridView.builder(
          //     itemCount: 8,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2),
          //     itemBuilder: (context, index) {
          //       return Card(
          //         child: Center(
          //           child: Text('Card $index'),
          //         ),
          //       );
          //     }),
          ),
    );
  }
}
