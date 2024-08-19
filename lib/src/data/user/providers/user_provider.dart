import '../../../domain/domain.dart';

/// User Provider
abstract class UserProvider {
  /// The first time you use the QA SDK in the code you should initialize it, this allows the SDK
  /// to create a unique identifier and initiate server transactions and workflows.
  /// Most of the functionality will not work if you have never initialized the singleton before.
  /// The function is synchronous and return a flow with the status of the registration of the
  /// device to the server. NOTE: do not use this function without collecting the flow otherwise
  /// the function will not be called at all.
  /// [apiKey] is the API key provided by the QA team.
  /// [yearOfBirth] is the age of the user.
  /// [selfDeclaredHealthy] is a boolean that indicates if the user is healthy.
  /// [identityId] is the unique identifier of the user (used for returning users).
  /// [password] is the password of the user (used for returning users).
  Future<bool> init({
    required String apiKey,
    int? yearOfBirth,
    Gender? gender,
    bool? selfDeclaredHealthy,
    String? identityId,
    String? password,
  });

  /// Update the basic information of the user. The user might not have given
  /// this information initially but might be prompted to give it later.
  Future<void> updateBasicInfo({
    int? newYearOfBirth,
    Gender? newGender,
    bool? newSelfDeclaredHealthy,
  });

  /// Get the basic information of the user.
  Future<String> getBasicInfo();

  /// Get the password of the user.
  Future<String?> getPassword();

  /// Get the identity id of the user.
  Future<String> getIdentityId();
}
