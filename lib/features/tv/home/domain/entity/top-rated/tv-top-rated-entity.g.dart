// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv-top-rated-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvTopRatedEntityAdapter extends TypeAdapter<TvTopRatedEntity> {
  @override
  final int typeId = 7;

  @override
  TvTopRatedEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvTopRatedEntity(
      description: fields[2] as String,
      id: fields[6] as int,
      image: fields[1] as String,
      language: fields[5] as String,
      name: fields[0] as String,
      rating: fields[3] as double,
      ratingCount: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TvTopRatedEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.ratingCount)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvTopRatedEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
