import 'package:kdbx/kdbx.dart';
import 'package:saf_stream/saf_stream.dart';

import 'package:enclave/models/entry_model.dart';

class KdbxService {
  final SafStream _safStream = SafStream();
  final KdbxFormat _kdbxFormat = KdbxFormat();

  Future<KdbxFile> validatePassword({
    required String uri,
    required String password,
  }) async {
    final bytes = await _safStream.readFileBytes(uri);

    final database = await _kdbxFormat.read(
      bytes,
      Credentials(ProtectedValue.fromString(password)),
    );

    return database;
  }

  List<EntryModel> readEntries(KdbxFile database) {
    final group = database.body.rootGroup;

    final entries = <EntryModel>[];

    for (final entry in group.entries) {
      final model = EntryModel(
        uuid: entry.uuid.uuid,
        title: entry.getString(KdbxKeyCommon.TITLE)?.getText() ?? '',
        username: entry.getString(KdbxKeyCommon.USER_NAME)?.getText() ?? '',
        password: entry.getString(KdbxKeyCommon.PASSWORD)?.getText() ?? '',
        url: entry.getString(KdbxKeyCommon.URL)?.getText() ?? '',
        notes: entry.getString(KdbxKey('Notes'))?.getText() ?? '',
      );

      entries.add(model);
    }

    return entries;
  }
}
