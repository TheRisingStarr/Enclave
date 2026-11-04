import 'package:kdbx/kdbx.dart';
import 'package:saf_stream/saf_stream.dart';
import 'package:enclave/models/group_model.dart';
import 'package:enclave/models/entry_model.dart';

class KdbxService {
  final SafStream _safStream = SafStream();
  final KdbxFormat _kdbxFormat = KdbxFormat();

  Future<KdbxFile> validatePassword({
    required String uri,
    required String password,
  }) async {
    final bytes = await _safStream.readFileBytes(uri);

    return _kdbxFormat.read(
      bytes,
      Credentials(ProtectedValue.fromString(password)),
    );
  }

  GroupModel readRootGroup(KdbxFile database) {
    return _toGroup(database.body.rootGroup);
  }

  GroupModel _toGroup(KdbxGroup group) {
    return GroupModel(
      uuid: group.uuid.uuid,
      name: group.name.get() ?? '',
      entries: group.entries.map(_toEntry).toList(),
      groups: group.groups.map(_toGroup).toList(),
    );
  }

  EntryModel _toEntry(KdbxEntry entry) {
    return EntryModel(
      uuid: entry.uuid.uuid,
      title: entry.getString(KdbxKeyCommon.TITLE)?.getText() ?? '',
      username: entry.getString(KdbxKeyCommon.USER_NAME)?.getText() ?? '',
      password: entry.getString(KdbxKeyCommon.PASSWORD)?.getText() ?? '',
      url: entry.getString(KdbxKeyCommon.URL)?.getText() ?? '',
      notes: entry.getString(KdbxKey('Notes'))?.getText() ?? '',
    );
  }
}
