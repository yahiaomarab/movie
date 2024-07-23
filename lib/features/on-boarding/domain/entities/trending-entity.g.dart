// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendingEntityAdapter extends TypeAdapter<TrendingEntity> {
  @override
  final int typeId = 0;

  @override
  TrendingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrendingEntity(
      posterImage: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrendingEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.posterImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
