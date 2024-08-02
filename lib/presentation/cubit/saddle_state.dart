import 'package:catalogue_saddle/data/model/saddle_model.dart';
import 'package:equatable/equatable.dart';


abstract class SaddleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaddleInitial extends SaddleState {}

class SaddleLoading extends SaddleState {}

class SaddleSuccess extends SaddleState {
  final List<SaddleModel> saddles;

  SaddleSuccess({required this.saddles});

  @override
  List<Object?> get props => [saddles];
}

class SaddleError extends SaddleState {
  final String message;

  SaddleError({required this.message});

  @override
  List<Object?> get props => [message];
}
