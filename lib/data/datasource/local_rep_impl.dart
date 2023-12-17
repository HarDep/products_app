import 'package:products_app/domain/models/user.dart';
import 'package:products_app/domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _prefToken = 'TOKEN';
const String _prefUsername = 'USERNAME';
const String _prefName = 'NAME';
const String _prefImage = 'IMAGE';
const String _prefDarkTheme = 'ISDARKTHEME';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> cleanInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefToken);
  }

  @override
  Future<String?> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isRight = await sharedPreferences.setString(_prefToken, token);
    return isRight ? token : null;
  }

  @override
  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? name = sharedPreferences.getString(_prefName);
    final String? username = sharedPreferences.getString(_prefUsername);
    final String? image = sharedPreferences.getString(_prefImage);
    return name != null && username != null
        ? User(name: name, username: username, image: image)
        : null;
  }

  @override
  Future<User?> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool isRightName =
        await sharedPreferences.setString(_prefName, user.name);
    final bool isRightUsername =
        await sharedPreferences.setString(_prefUsername, user.username);
    if (user.image != null) {
      await sharedPreferences.setString(_prefImage, user.image!);
    }
    return isRightName && isRightUsername ? user : null;
  }

  @override
  Future<bool> getIsDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_prefDarkTheme)??false;
  }

  @override
  Future<void> saveIsDarkMode(bool isDarkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_prefDarkTheme, isDarkMode);
  }
}
