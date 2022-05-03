import 'package:shared_preferences/shared_preferences.dart';
import 'session.dart';
import 'dart:convert';

class SpHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  List<Session> getSessions() {
    List<Session> sessions = [];
    Set<String> keys = prefs.getKeys();
    for (var key in keys) {
      if (key == "counter") continue;
      Session session =
          Session.formJson(json.decode(prefs.getString(key) ?? ""));
      sessions.add(session);
    }
    return sessions;
  }

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('conter') ?? 0;
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}