import 'package:bloc/bloc.dart';
import 'package:catalogue_saddle/data/repository/saddle_repository.dart';
import 'package:catalogue_saddle/presentation/cubit/saddle_state.dart';
import '../../data/model/saddle_model.dart';

class SaddleCubit extends Cubit<SaddleState> {
  final SaddleRepository saddleRepository;

  SaddleCubit({required this.saddleRepository}) : super(SaddleInitial());


  Future<void> createSaddle(SaddleModel saddle) async {
    try {
      emit(SaddleLoading());
      final rsp_1 = await saddleRepository.createSaddle(saddle);
      final saddles = await saddleRepository.getAllSaddles();
      emit(SaddleSuccess(saddles: saddles));

    } catch (e) {
      emit(SaddleError(message: e.toString()));
    }
  }


  Future<void> updateSaddle(SaddleModel saddle) async {
    try {
      emit(SaddleLoading());
      final saddles = await saddleRepository.updateSaddle(saddle);
      
      emit(SaddleSuccess(saddles: [saddles]));
    } catch (e) {
      emit(SaddleError(message: e.toString()));
    }
  }

  Future<void> deleteSaddle(String id) async {
    try {
      emit(SaddleLoading());
      final saddles = await saddleRepository.deleteSaddle(id);
      if (saddles.id.toString() == id) {
        final saddles = await saddleRepository.getAllSaddles();
        emit(SaddleSuccess(saddles: saddles));
      } else {
        emit(SaddleError(message: 'Failed to delete saddle'));
      }
    } catch (e) {
      emit(SaddleError(message: e.toString()));
    }
  }

  Future<void> fetchAllSaddles() async {
    try {
      emit(SaddleLoading());
      final saddles = await saddleRepository.getAllSaddles();
      emit(SaddleSuccess(saddles: saddles));
    } catch (e) {
      emit(SaddleError(message: e.toString()));
    }
  }
}
