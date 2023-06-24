import 'dart:math';

class StringUtil {
  String generateRandomNumber({required int length}) {
    Random random = Random();
    String number = '';

    for (int i = 0; i < length; i++) {
      number += random.nextInt(10).toString();
    }

    return number;
  }
}
