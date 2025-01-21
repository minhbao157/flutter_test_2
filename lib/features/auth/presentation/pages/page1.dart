//Flutter Core Packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Cubit
import '../cubits/counter_cubit.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter 1')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state){
                return Text(
                  'Number: ${state.counter}',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();  
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: (){
                    context.read<CounterCubit>().increment();
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
