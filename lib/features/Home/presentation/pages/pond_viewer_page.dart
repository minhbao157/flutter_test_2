import 'package:flutter/material.dart';

import '../../domain/entities/pond.dart';

class PondViewerPage extends StatelessWidget {
  final Pond pond;
  const PondViewerPage({
    super.key,
    required this.pond,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin Ao'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(pond.imageUrl),
            ),
            const SizedBox(height: 10),
            Text(
              'Diện Tích: ${pond.area}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Độ Sâu: ${pond.deep}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Chi Phí: ${pond.costs}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Số Vụ Nuôi Có Thể Sử Dụng: ${pond.active}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}