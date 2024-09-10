import 'package:either_dart/either.dart';
import 'package:opennz_ua/network.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Either<UserModel, AuthErrorModel>> authByLoginAndPassword(
      AuthByPasswordCredentialModel credentials) async {
    final response = await http.post(
      Uri.parse('${BaseUrls.NZ_UA_API_BASE_URL}/user/login'),
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
