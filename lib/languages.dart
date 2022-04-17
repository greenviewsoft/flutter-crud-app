import 'package:get/get.dart';
import 'package:my_firstapp/language/ban.dart';
import 'package:my_firstapp/language/eng.dart';
import 'package:my_firstapp/language/hi.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': eng,
        'bn_BD': ban,
        'hi_IN': hi,
      };
}
