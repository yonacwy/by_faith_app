import 'package:hive/hive.dart';
import 'gospel_map_entry_data_model.dart'; // Import the new MapEntryData model

part 'gospel_map_sub_directory_model.g.dart';

@HiveType(typeId: 3)
class SubDirectory extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<GospelMapEntryData> maps; // Use MapEntryData

  @HiveField(2)
  final List<SubDirectory> subDirectories;

  SubDirectory({
    required this.name,
    this.maps = const [],
    this.subDirectories = const [],
  });

  factory SubDirectory.fromJson(Map<String, dynamic> json, Map<String, Map<String, dynamic>> coordinateMap) => SubDirectory(
        name: json['name'] as String,
        maps: (json['maps'] as List<dynamic>?)
                ?.map((m) => GospelMapEntryData.fromJson(m as Map<String, dynamic>, coordinateMap)) // Use MapEntryData.fromJson
                .toList() ??
            [],
        subDirectories: (json['subDirectories'] as List<dynamic>?)
                ?.map((s) => SubDirectory.fromJson(s as Map<String, dynamic>, coordinateMap))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'maps': maps.map((m) => m.toJson()).toList(),
        'subDirectories': subDirectories.map((s) => s.toJson()).toList(),
      };
}