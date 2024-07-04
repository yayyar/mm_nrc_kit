class NrcData {
  static const state = 'packages/mm_nrc_kit/assets/state.json';

  static const township = 'packages/mm_nrc_kit/assets/township.json';

  static const type = 'packages/mm_nrc_kit/assets/type.json';

  static const enPattern = r'^[0-9]{1,2}/[a-zA-Z]+\([a-zA-Z]{1}\)[0-9]{6}$';

  static const mmPattern =
      r'^[\u1040-\u1049]{1,2}/[\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+(\([\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+\))[\u1040-\u1049]{6}$';

  static const enPrefixPattern = r'^[0-9]{1,2}/[a-zA-Z]+\([a-zA-Z]{1}\)';

  static const mmPrefixPattern =
      r'^[\u1040-\u1049]{1,2}/[\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+(\([\u1000-\u109F\uAA60-\uAA7F\u1031\u1032\u1036-\u103A\u103B-\u103E]+\))';
}
