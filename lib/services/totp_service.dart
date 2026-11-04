import 'package:totp/totp.dart';
import 'package:enclave/models/entry_model.dart';

class TotpService {
  String? generateCode(EntryModel entry) {
    final secret = entry.totpSecret;

    if (secret == null || secret.isEmpty) {
      return null;
    }

    final totp = Totp.fromBase32(
      secret: secret,
      algorithm: _getAlgorithm(entry.totpAlgorithm),
      digits: entry.totpDigits,
      period: entry.totpPeriod,
    );

    return totp.now();
  }

  int remainingSeconds(EntryModel entry) {
    final totp = Totp.fromBase32(
      secret: entry.totpSecret!,
      algorithm: _getAlgorithm(entry.totpAlgorithm),
      digits: entry.totpDigits,
      period: entry.totpPeriod,
    );

    return totp.remaining;
  }

  Algorithm _getAlgorithm(String algorithm) {
    switch (algorithm.toUpperCase()) {
      case 'SHA256':
        return Algorithm.sha256;
      case 'SHA512':
        return Algorithm.sha512;
      default:
        return Algorithm.sha1;
    }
  }
}
