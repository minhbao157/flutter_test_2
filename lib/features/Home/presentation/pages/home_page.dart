import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/core/common/widgets/loader.dart';
import 'package:namer_app/core/utils/show_snackbar.dart';
import 'package:namer_app/features/Home/presentation/pond/pond_bloc.dart';
import 'package:namer_app/features/Home/presentation/widgets/pond_card.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const HomePage()
  );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    context.read<PondBloc>().add(PondFetchAllPonds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: (){
              context.push('/add-new-pond');
            }, 
            icon: const Icon(
              Icons.add_circle_outline
            ),
          ),
        ],
      ),
      body: BlocConsumer<PondBloc, PondState>(
        listener: (context, state) {
          if(state is PondFailure){
            showSanckBar(context, state.error);
          }
        },
        builder: (context, state) {
          if(state is PondLoading){
            return const Loader();
          }
          if(state is PondDisplaySuccess){          
            return ListView.builder(
              itemCount: state.ponds.length,
              itemBuilder: (context, index){
                final pond = state.ponds[index];
                return PondCard(
                  pond: pond, 
                  color: Colors.white70,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}