import 'package:catalogue_saddle/data/model/saddle_model.dart';
import 'package:catalogue_saddle/data/repository/saddle_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/saddle_cubit.dart';

class SaddleCreateScreen extends StatefulWidget {
  const SaddleCreateScreen({Key? key}) : super(key: key);

  @override
  _SaddleCreateScreenState createState() => _SaddleCreateScreenState();
}

class _SaddleCreateScreenState extends State<SaddleCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _materialController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaddleCubit(
        saddleRepository: RepositoryProvider.of<SaddleRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar una silla de montar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la marca';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el modelo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _materialController,
                  decoration: const InputDecoration(labelText: 'Material'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el material';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'Tamaño'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el tamaño';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final saddle = SaddleModel(
                        id: 0, // El ID es generado por el backend
                        brand: _brandController.text,
                        model: _modelController.text,
                        material: _materialController.text,
                        size: _sizeController.text,
                      );

                      // Llama al método `createSaddle` del SaddleCubit
                      context.read<SaddleCubit>().createSaddle(saddle);

                      Navigator.of(context).pop();




                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Registrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
