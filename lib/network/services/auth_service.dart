import 'package:either_dart/either.dart';
import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String nzBaseURL = "https://api-mobile.nz.ua/v1";

  Future<Either<UserModel, AuthErrorModel>> authByLoginAndPassword(
      AuthByPasswordCredentialModel credentials) async {
    final response = await http.post(
      Uri.parse('$nzBaseURL/user/login'),
      // headers: nzHeaders,
      body: credentials.toJson(),
    );

    if (response.statusCode == 200) {
      return Left(userModelFromJson(response.body));
    } else {
      return Right(authErrorModelFromJson(response.body));
    }
  }
}
