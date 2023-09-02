import 'package:equatable/equatable.dart';

abstract class ExptWeb extends Equatable implements Exception {}

class ExptWebConnection extends ExptWeb {
  final String message;
  final int code ;
  ExptWebConnection([this.message = 'ExptWebConnection', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptWebGet extends ExptWeb {
  final String message;
  final int code;
  ExptWebGet([this.message = 'ExptWebGet', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}
class ExptWebPost extends ExptWeb {
  final String message;
  final int code;
  ExptWebPost([this.message = 'ExptWebPost', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptWebUnknown extends ExptWeb {
  final String message;
  final int code;
  ExptWebUnknown([this.message = 'ExptWebUnknown', this.code = 0]);
  
  @override
  List<Object?> get props => [message,code];
}


class ExptWebNoExpt extends ExptWeb {
  final int code;
  ExptWebNoExpt([this.code = 0]);

  @override
  List<Object?> get props => [code];
}
