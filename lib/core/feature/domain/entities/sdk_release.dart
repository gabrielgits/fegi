
import 'package:equatable/equatable.dart';

class SdkRelease extends Equatable {
  final int id;
  final String version;
  final String architecture;
  final String date;
  final String dartVersion;
  final int state;
  final String changeLog;
  final String link;
  final String file;
  final String channel;

 const SdkRelease({
    required this.id,
    required this.version,
    required this.architecture,
    required this.date,
    required this.dartVersion,
    required this.state,
    required this.changeLog,
    required this.link,
    required this.file,
    required this.channel,
  });
  
  @override
  List<Object?> get props => [
    id,
    version,
    architecture,
    date,
    dartVersion,
    state,
    changeLog,
    link,
    file,
    channel,
  ];
}
