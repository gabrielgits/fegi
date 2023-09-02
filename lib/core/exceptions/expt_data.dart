import 'package:equatable/equatable.dart';

abstract class ExptData extends Equatable implements Exception {}

class ExptDataOpen extends ExptData {
  final String message;
  final int code ;
  ExptDataOpen([this.message = 'ExptDataOpen', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptDataLoad extends ExptData {
  final String message;
  final int code;
  ExptDataLoad([this.message = 'ExptDataLoad', this.code = 0]);
  
  @override
  List<Object?> get props => [message, code];
}

class ExptDataSave extends ExptData {
  final String message;
  final int code;
  ExptDataSave([this.message = 'ExptDataSave', this.code = 0]);
  
  @override
  List<Object?> get props => [message,code];
}
class ExptDataDelete extends ExptData {
  final String message;
  final int code;
  ExptDataDelete([this.message = 'ExptDataDelete', this.code = 0]);
  
  @override
  List<Object?> get props => [message,code];
}

class ExptDataUnknown extends ExptData {
  final String message;
  final int code;
  ExptDataUnknown([this.message = 'ExptDataUnknown', this.code = 0]);
  
  @override
  List<Object?> get props => [message,code];
}


class ExptDataNoExpt extends ExptData {
  final int code;
  ExptDataNoExpt([this.code = 0]);

  @override
  List<Object?> get props => [code];
}
