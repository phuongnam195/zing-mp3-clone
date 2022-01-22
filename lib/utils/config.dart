import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/account.dart';
import '../models/playlist.dart';

class Config {
  static final Config instance = Config._internal();
  Config._internal();

  Account? myAccount;

  // Lưu thông tin tài khoản hiện hành
  Future<void> saveAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('account_uid', myAccount!.uid);
    await prefs.setString('account_email', myAccount!.email);
    await prefs.setString('account_name', myAccount!.name);
  }

  // Lưu danh sách playlist của tài khoản hiện hành
  Future<void> saveAccountPlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final listStringMap =
        myAccount!.userPlaylists.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList('account_playlists', listStringMap);
  }

  // Nạp thông tin và playlists của tài khoản hiện hành
  Future<void> loadAccountData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('account_uid') ?? "";
    final email = prefs.getString('account_email') ?? "";
    final name = prefs.getString('account_name') ?? "";

    final listStringMap = prefs.getStringList('account_playlists') ?? [];
    final playlists = listStringMap.map((e) {
      final map = jsonDecode(e);
      return Playlist.fromMap(map, map['id']);
    }).toList();

    myAccount =
        Account(uid: uid, name: name, email: email, userPlaylists: playlists);
  }
}
