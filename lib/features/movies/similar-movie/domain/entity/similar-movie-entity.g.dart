// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar-movie-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimilarMovieEntityAdapter extends TypeAdapter<SimilarMovieEntity> {
  @override
  final int typeId = 4;

  @override
  SimilarMovieEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimilarMovieEntity(
      ID: fields[1] as int,
      image: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SimilarMovieEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.ID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimilarMovieEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
