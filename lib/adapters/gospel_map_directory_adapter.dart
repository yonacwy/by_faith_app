import 'package:hive/hive.dart';
import '../ui/gospel_page_ui.dart';
import '../models/gospel_map_directory_model.dart';
import '../models/gospel_map_sub_directory_model.dart';

class GospelMapDirectoryAdapter extends TypeAdapter<Directory> {
  @override
  final int typeId = 4;

  @override
  Directory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Directory(
      name: fields[0] as String,
      subDirectories: (fields[1] as List).cast<SubDirectory>(),
    );
  }

  @override
  void write(BinaryWriter writer, Directory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subDirectories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GospelMapDirectoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}