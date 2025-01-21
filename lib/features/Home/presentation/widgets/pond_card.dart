import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/pond.dart';

class PondCard extends StatelessWidget {
  final Pond pond;
  final Color color;
  const PondCard({
    super.key,
    required this.pond,
    required this.color,  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
        context.push('/pond-page', extra: pond);
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(
          bottom: 4,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: pond.topics
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Chip(label: Text(e)),
                  ),
                )
                .toList(),
              ),
            ),
            Text(
              pond.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}