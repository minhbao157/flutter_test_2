import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/counter.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            'Number: ${counter.counter}',
            style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    counter.decrement();  
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: (){
                    counter.increment();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push('/page2'),
              child: const Text('Go to Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}
