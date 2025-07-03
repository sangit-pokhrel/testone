// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterHiveModelAdapter extends TypeAdapter<RegisterHiveModel> {
  @override
  final int typeId = 0;

  @override
  RegisterHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterHiveModel(
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      phone: fields[4] as String,
      country: fields[5] as String,
      province: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.province);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
