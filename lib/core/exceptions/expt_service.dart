import 'package:equatable/equatable.dart';

abstract class ExptService extends Equatable implements Exception {}

class ExptServiceLoad extends ExptService {
  final String message;
  final int code ;
  ExptServiceLoad([this.message = 'ExptServiceLoad', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptServiceExecute extends ExptService {
  final String message;
  final int code;
  ExptServiceExecute([this.message = 'ExptServiceExecute', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptServiceUnknown extends ExptService {
  final String message;
  final int code;
  ExptServiceUnknown([this.message = 'ExptServiceUnknown', this.code = 0]);
  
  @override
  List<Object?> get props => [message,code];
}


class ExptServiceNoExpt extends ExptService {
  final int code;
  ExptServiceNoExpt([this.code = 0]);

  @override
  List<Object?> get props => [code];
}
