import 'package:equatable/equatable.dart';

sealed class ControllerState extends Equatable {}

class ControllerStateLoading extends ControllerState {
  final String message;
  ControllerStateLoading([this.message = 'LoadingState']);

  @override
  String toString() {
    return message;
  }
  
  @override
  List<Object?> get props => [message];

}

class ControllerStateLoaded extends ControllerState {
  final String message;
  ControllerStateLoaded([this.message = 'LoadedState']);
    @override
  String toString() {
    return message;
  }

    @override
  List<Object?> get props => [message];
}

class ControllerStateEmpty extends ControllerState {
  final String message;
  ControllerStateEmpty([this.message = 'EmptyState']);
    @override
  String toString() {
    return message;
  }

    @override
  List<Object?> get props => [message];
}

class ControllerStateError extends ControllerState {
  final String message;
  ControllerStateError([this.message = 'ErrorState']);
    @override
  String toString() {
    return message;
  }

    @override
  List<Object?> get props => [message];
}