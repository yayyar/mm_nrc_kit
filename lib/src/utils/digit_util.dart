class DigitUtil {
  static String myanmarToEnglishDigit(String myanmarDigit) {
    const myanmarDigits = '၀၁၂၃၄၅၆၇၈၉';
    const englishDigits = '0123456789';

    final index = myanmarDigits.indexOf(myanmarDigit);
    if (index != -1) {
      return englishDigits[index];
    } else {
      return myanmarDigit;
    }
  }
}
