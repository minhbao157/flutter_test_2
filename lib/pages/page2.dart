import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/provider/counter.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget{
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    final Counter counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Page 2'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Number: ${counter.count}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    counter.decrement();
                  }, 
                  icon: const Icon(Icons.remove),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: (){
                context.pop();
              }, child: const Text('Back to page 1')),
          ],
        ),
      ),
    );
  }
}