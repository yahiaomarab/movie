// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchEntityAdapter extends TypeAdapter<SearchEntity> {
  @override
  final int typeId = 3;

  @override
  SearchEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchEntity(
      image: fields[1] as String,
      name: fields[0] as String,
      ID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SearchEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.ID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
