import 'package:file_picker/file_picker.dart';
import 'package:android_file_picker/android_file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import 'package:enclave/screens/master_pwd_page.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({super.key});

  Future<void> selectDatabase(BuildContext context) async {
    final file = await FilePicker.pickFile(
      androidOptions: const FilePickerAndroidOptions(
        safOptions: AndroidSAFOptions(
          grant: AndroidSAFGrant.lifetime,
          accessMode: AndroidSAFAccessMode.readWrite,
          persistGrant: true,
        ),
      ),
    );

    if (file == null) return;

    final prefs = await SharedPreferences.getInstance();

    final uri = file.uri.toString();

    await prefs.setString('database_uri', uri);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MasterPwdPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: M3EAppBar.top(
        titleText: "Enclave",
        variant: M3EAppBarVariant.mediumFlexible,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => selectDatabase(context),
          child: const Text("Select database"),
        ),
      ),
    );
  }
}
