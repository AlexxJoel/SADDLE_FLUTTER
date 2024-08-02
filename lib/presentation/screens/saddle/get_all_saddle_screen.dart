import 'package:catalogue_saddle/presentation/screens/saddle/saddle_create_screen.dart';
import 'package:catalogue_saddle/presentation/screens/saddle/saddle_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/saddle_repository.dart';
import '../../cubit/saddle_cubit.dart';
import '../../cubit/saddle_state.dart';

class SaddleListView extends StatelessWidget {
  const SaddleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de sillas de montar')
      ),
      body: BlocProvider(
        create: (context) => SaddleCubit(
          saddleRepository: RepositoryProvider.of<SaddleRepository>(context),
        ),
        child: const SaddleListScreen(),
      ),
    );
  }
}

class SaddleListScreen extends StatelessWidget {
  const SaddleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saddleCubit = BlocProvider.of<SaddleCubit>(context); //

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            saddleCubit.fetchAllSaddles();
          },
          child: const Text('Obtener registros'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const SaddleCreateScreen(),
            ));
          },
          child: const Text('Registrar una silla de montar')
        ),
        Expanded(
          child: BlocBuilder<SaddleCubit, SaddleState>(
            builder: (context, state) {
              if (state is SaddleLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SaddleSuccess) {
                final saddles = state.saddles;
                //   retunr a table with all atributtes

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(top: 20),
                  child: Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(
                        children: [
                          TableCell(
                              child: Text('ID',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('Marca',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('Modelo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('Material',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('tamaño',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('Eliminar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          TableCell(
                              child: Text('Actualizar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                        ],
                      ),
                      for (int i = 0; i < saddles.length; i++)
                        TableRow(
                          children: <Widget>[
                            TableCell(
                              child: Text((i + 1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(saddles[i].brand),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(saddles[i].model),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(saddles[i].material),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(saddles[i].size),
                            )),
                            TableCell(
                                child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                saddleCubit.deleteSaddle(saddles[i].id.toString());
                              },
                            )),
                            TableCell(
                                child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      SaddleUpdateScreen(saddle: saddles[i]),
                                ));
                              },
                            )),
                          ],
                        ),
                    ],
                  ),
                );
              } else if (state is SaddleError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(
                  child: Text('Presione el botón para obtener registros'));
            },
          ),
        ),
      ],
    );
  }
}
