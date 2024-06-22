import 'dart:convert';

class Name {
  final String en;
  final String mm;
  Name({
    required this.en,
    required this.mm,
  });

  Name copyWith({
    String? en,
    String? mm,
  }) {
    return Name(
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

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      en: map['en'] as String,
      mm: map['mm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) =>
      Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Name(en: $en, mm: $mm)';

  @override
  bool operator ==(covariant Name other) {
    if (identical(this, other)) return true;

    return other.en == en && other.mm == mm;
  }

  @override
  int get hashCode => en.hashCode ^ mm.hashCode;
}
