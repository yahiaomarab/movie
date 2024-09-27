// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendingEntityAdapter extends TypeAdapter<TrendingEntity> {
  @override
  final int typeId = 1;

  @override
  TrendingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrendingEntity(
      image: fields[0] as String,
      kind: fields[1] as String,
      name: fields[2] as String,
      price: fields[3] as String,
      status: fields[4] as String,
      ID: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TrendingEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.kind)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.ID);
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
