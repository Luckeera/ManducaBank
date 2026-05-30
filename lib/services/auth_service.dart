import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> autenticar() async {
    try {
      bool podeAutenticar =
          await auth.canCheckBiometrics ||
          await auth.isDeviceSupported();

      if (!podeAutenticar) {
        return false;
      }

      bool autenticado = await auth.authenticate(
        localizedReason: 'Use sua biometria para entrar',
        biometricOnly: true,
      );

      return autenticado;

    } catch (e) {
      return false;
    }
  }
}