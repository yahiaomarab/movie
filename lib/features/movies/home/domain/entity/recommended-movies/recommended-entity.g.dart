// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendedEntityAdapter extends TypeAdapter<RecommendedEntity> {
  @override
  final int typeId = 2;

  @override
  RecommendedEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecommendedEntity(
      image: fields[0] as String,
      name: fields[1] as String,
      ID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecommendedEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendedEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
