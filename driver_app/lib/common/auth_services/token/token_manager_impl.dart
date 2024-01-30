import 'package:jwt_decoder/jwt_decoder.dart';

import '../../app_storage/app_storage.dart';
import '../../app_storage/constants/app_storage_keys.dart';
import '../../di/injector.dart';
import '../authentication/enum/authentication_type.dart';
import '../authentication/manager/authentication_manager.dart';
import 'token_manager.dart';

class TokenManagerImpl implements TokenManager{

  TokenManagerImpl();

  @override
  Future<String?> getSecurelyStoredToken() async{

    ///1. Fetch token from Secure Storage.
    var token = await AppStorage.fetchString(key: AppStorageKey.token,secured: true);

    ///1.1 Fetch Authentication type from Storage.
    var authenticationType = await AppStorage.fetchString(key: AppStorageKey.authenticationType);

    var authenticationManager = injector<AuthenticationManager>();

    if(token!=null && authenticationType!=null){
      ///2. Check if the token is Expired.
      var isTokenExpired = JwtDecoder.isExpired(token);

      ///3. Aquire token silently if it is expired.
      if(isTokenExpired){
        await authenticationManager.authenticateSilently(authenticationType.toAuthenticationType()).then((newToken) async{
          ///4. If newToken is not null then save it in secure storage.
          if(newToken!=null){
            await saveTokenSecurely(newToken,authenticationType.toAuthenticationType());

            ///5. Update the value of token.
            token = newToken;
          }
        });
      }
    }

    return Future.value(token);
  }

  @override
  Future<void> saveTokenSecurely(String token,AuthenticationType authenticationType) async {
    AppStorage.saveSecurely(key: AppStorageKey.token, value: token).then((value) async{
      AppStorage.save(key: AppStorageKey.isAuthenticated, value: true);
      AppStorage.save(key: AppStorageKey.authenticationType, value: authenticationType.name);
    });
  }

}
