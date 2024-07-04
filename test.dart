void main() {
  String testString = '၈/မကန(နိုင်)၁၀၃၄၂၁';
  RegExp myanmarRegExp = RegExp(
      r'^[\u1040-\u1049]{1,2}/[\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+(\([\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+\))[\u1040-\u1049]{6}$');

  bool isValid = myanmarRegExp.hasMatch(testString);
  print(isValid); // Should print: true
}
