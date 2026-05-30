import 'package:file_picker/file_picker.dart';
import 'package:android_file_picker/android_file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> selectDatabase() async {
  final file = await FilePicker.pickFile(
    androidOptions: const FilePickerAndroidOptions(
      safOptions: AndroidSAFOptions(
        grant: AndroidSAFGrant.lifetime,
        accessMode: AndroidSAFAccessMode.readWrite,
        persistGrant: true,
      ),
    ),
  );

  if (file == null) {
    return;
  }

  final prefs = await SharedPreferences.getInstance();

  final uri = file.uri.toString();
  await prefs.setString('database_uri', uri);
}
