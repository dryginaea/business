import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OAuthSecureStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final accessTokenKey = 'accessToken';
  final pushToken = 'pushToken';
  final avatar = 'avatar';
  final promocode = 'promocode';

  Future<void> clear() async {
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: pushToken);
    await storage.delete(key: avatar);
    await storage.delete(key: promocode);
  }

  Future<String> fetch() async {
    return await storage.read(key: accessTokenKey);
  }

  Future<String> saveToken(String token) async {
    await storage.write(key: accessTokenKey, value: token);
    return token;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: accessTokenKey);
  }

  Future<String> getPushToken() async {
    return await storage.read(key: pushToken);
  }

  Future<String> savePushToken(String token) async {
    await storage.write(key: pushToken, value: token);
    return pushToken;
  }

  Future<void> saveAvatar(String avatar_value) async {
    await storage.write(key: avatar, value: avatar_value);
  }

  Future<String> getAvatar() async {
    return await storage.read(key: avatar);
  }

  Future<void> savePromocode(String promo) async {
    await storage.write(key: promocode, value: promo);
  }

  Future<String> getPromocode() async {
    return await storage.read(key: promocode);
  }

  Future<void> deletePromocode() async {
    await storage.delete(key: promocode);
  }
}