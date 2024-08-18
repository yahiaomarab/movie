// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding-entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnBoardingEntityAdapter extends TypeAdapter<OnBoardingEntity> {
  @override
  final int typeId = 0;

  @override
  OnBoardingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnBoardingEntity(
      posterImage: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OnBoardingEntity obj) {
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
      other is OnBoardingEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
