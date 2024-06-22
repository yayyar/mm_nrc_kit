/// Nrc model is used for user's nrc string and splited string
class Nrc {
  final String stateCode;
  final String townshipCode;
  final String nrcType;
  final String nrcNo;

  Nrc(
      {required this.stateCode,
      required this.townshipCode,
      required this.nrcType,
      required this.nrcNo});
}
