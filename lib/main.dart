import 'package:catalogue_saddle/presentation/cubit/saddle_cubit.dart';
import 'package:catalogue_saddle/presentation/screens/saddle/get_all_saddle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/saddle_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SaddleRepository(
            apiURL:
                'https://ne3sgpnjh9.execute-api.us-west-1.amazonaws.com/Prod', // Reemplaza con tu URL
            //accessToken: 'your-access-token', // Reemplaza con tu token
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => SaddleCubit(
          saddleRepository: RepositoryProvider.of<SaddleRepository>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SaddleListView(), // Cambia esto para mostrar tu vista
        ),
      ),
    );
  }
}
