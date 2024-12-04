import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/counter.dart';

class Page1 extends StatelessWidget{
  const Page1({super.key});

  @override
  Widget build(BuildContext context ){
    final Counter counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Page 1'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Number: ${counter.count}',
              style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
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
              const SizedBox(height: 20),
              TextButton(
               onPressed: (){
                context.go('/page2');
              },
              child: const Text('Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}