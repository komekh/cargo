import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';
import '../../models/models.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();

  Future<String> getFBToken();

  Future<UserModel> getUser();

  Future<void> saveToken(String token);

  Future<void> saveFBToken(String token);

  Future<void> saveUser(UserModel user);

  Future<void> clearCache();

  Future<bool> isTokenAvailable();
}

const cachedToken = 'TOKEN';
const cachedFBToken = 'FB_TOKEN';
const cachedUser = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> getToken() async {
    String? token = sharedPreferences.getString(cachedToken) ?? '';
    return token;
  }

  @override
  Future<String> getFBToken() async {
    String? token = sharedPreferences.getString(cachedFBToken) ?? '';
    return token;
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(cachedToken, token);
  }

  @override
  Future<void> saveFBToken(String token) async {
    await sharedPreferences.setString(cachedFBToken, token);
  }

  @override
  Future<UserModel> getUser() async {
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(userModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return sharedPreferences.setString(
      cachedUser,
      userModelToJson(user),
    );
  }

  @override
  Future<bool> isTokenAvailable() async {
    String? token = sharedPreferences.getString(cachedToken);
    return token != null;
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedToken);
    await sharedPreferences.remove(cachedFBToken);
    await sharedPreferences.remove(cachedUser);
  }
}
