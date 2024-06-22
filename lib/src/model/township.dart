import 'dart:convert';

import 'name.dart';

class Township {
  final String id;
  final String code;
  final Short short;
  final Name name;
  final String stateId;
  final String stateCode;
  Township({
    required this.id,
    required this.code,
    required this.short,
    required this.name,
    required this.stateId,
    required this.stateCode,
  });

  Township copyWith({
    String? id,
    String? code,
    Short? short,
    Name? name,
    String? stateId,
    String? stateCode,
  }) {
    return Township(
      id: id ?? this.id,
      code: code ?? this.code,
      short: short ?? this.short,
      name: name ?? this.name,
      stateId: stateId ?? this.stateId,
      stateCode: stateCode ?? this.stateCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'short': short.toMap(),
      'name': name.toMap(),
      'stateId': stateId,
      'stateCode': stateCode,
    };
  }

  factory Township.fromMap(Map<String, dynamic> map) {
    return Township(
      id: map['id'] as String,
      code: map['code'] as String,
      short: Short.fromMap(map['short'] as Map<String, dynamic>),
      name: Name.fromMap(map['name'] as Map<String, dynamic>),
      stateId: map['stateId'] as String,
      stateCode: map['stateCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Township.fromJson(String source) =>
      Township.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Township(id: $id, code: $code, short: $short, name: $name, stateId: $stateId, stateCode: $stateCode)';
  }

  @override
  bool operator ==(covariant Township other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.short == short &&
        other.name == name &&
        other.stateId == stateId &&
        other.stateCode == stateCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        short.hashCode ^
        name.hashCode ^
        stateId.hashCode ^
        stateCode.hashCode;
  }
}

class Short {
  final String en;
  final String mm;
  Short({
    required this.en,
    required this.mm,
  });

  Short copyWith({
    String? en,
    String? mm,
  }) {
    return Short(
      en: en ?? this.en,
      mm: mm ?? this.mm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'en': en,
      'mm': mm,
    };
  }

  factory Short.fromMap(Map<String, dynamic> map) {
    return Short(
      en: map['en'] as String,
      mm: map['mm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Short.fromJson(String source) =>
      Short.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Short(en: $en, mm: $mm)';

  @override
  bool operator ==(covariant Short other) {
    if (identical(this, other)) return true;

    return other.en == en && other.mm == mm;
  }

  @override
  int get hashCode => en.hashCode ^ mm.hashCode;
}
