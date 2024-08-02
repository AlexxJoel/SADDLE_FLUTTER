import 'package:catalogue_saddle/data/model/saddle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/saddle_cubit.dart';


class SaddleUpdateScreen extends StatefulWidget {
  final SaddleModel saddle;
  const SaddleUpdateScreen({Key? key, required this.saddle}) : super(key: key);

  @override
  _SaddleUpdateScreenState createState() => _SaddleUpdateScreenState();
}

class _SaddleUpdateScreenState extends State<SaddleUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _materialController;
  late TextEditingController _sizeController;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.saddle.brand);
    _modelController = TextEditingController(text: widget.saddle.model);
    _materialController = TextEditingController(text: widget.saddle.material);
    _sizeController = TextEditingController(text: widget.saddle.size);
  }

  @override
  Widget build(BuildContext context) {
    final saddleCubit = BlocProvider.of<SaddleCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Saddle'),
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
                    final updatedSaddle = SaddleModel(
                      id: widget.saddle.id, // Mantener el mismo ID
                      brand: _brandController.text,
                      model: _modelController.text,
                      material: _materialController.text,
                      size: _sizeController.text,
                    );
                    saddleCubit.updateSaddle(updatedSaddle);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
