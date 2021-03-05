import 'package:prettier_log/prettier_log.dart';

void main(){
  PrettierLog.setup("MY APP");
  PrettierLog().logE(">>>>>>> hello world <<<<<<<");
  PrettierLog().logW(">>>>>>> hello world <<<<<<<");
  PrettierLog().logD(">>>>>>> hello world <<<<<<<");
  PrettierLog().log(">>>>>>> hello world <<<<<<<");
}