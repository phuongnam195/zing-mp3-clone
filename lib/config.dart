import 'package:zing_mp3_clone/models/account.dart';

class Config {
  static final Config instance = Config._internal();
  Config._internal();

  Account? myAccount;
}
