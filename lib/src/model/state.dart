import 'dart:convert';

import 'name.dart';

class StateDivision {
  final String id;
  final String code;
  final Number number;
  final Name name;
  StateDivision({
    required this.id,
    required this.code,
    required this.number,
    required this.name,
  });

  StateDivision copyWith({
    String? id,
    String? code,
    Number? number,
    Name? name,
  }) {
    return StateDivision(
      id: id ?? this.id,
      code: code ?? this.code,
      number: number ?? this.number,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'number': number.toMap(),
      'name': name.toMap(),
    };
  }

  factory StateDivision.fromMap(Map<String, dynamic> map) {
    return StateDivision(
      id: map['id'] as String,
      code: map['code'] as String,
      number: Number.fromMap(map['number'] as Map<String, dynamic>),
      name: Name.fromMap(map['name'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory StateDivision.fromJson(String source) =>
      StateDivision.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'State(id: $id, code: $code, number: $number, name: $name)';
  }

  @override
  bool operator ==(covariant StateDivision other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.number == number &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ number.hashCode ^ name.hashCode;
  }
}

class Number {
  final String en;
  final String mm;
  Number({
    required this.en,
    required this.mm,
  });

  Number copyWith({
    String? en,
    String? mm,
  }) {
    return Number(
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

  factory Number.fromMap(Map<String, dynamic> map) {
    return Number(
      en: map['en'] as String,
      mm: map['mm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Number.fromJson(String source) =>
      Number.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Number(en: $en, mm: $mm)';

  @override
  bool operator ==(covariant Number other) {
    if (identical(this, other)) return true;

    return other.en == en && other.mm == mm;
  }

  @override
  int get hashCode => en.hashCode ^ mm.hashCode;
}
