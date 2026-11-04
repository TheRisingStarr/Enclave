import 'package:enclave/screens/homepage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/services/kdbx_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterPwdPage extends StatefulWidget {
  const MasterPwdPage({super.key});

  @override
  State<MasterPwdPage> createState() => _MasterPwdPageState();
}

class _MasterPwdPageState extends State<MasterPwdPage> {
  final TextEditingController pwdControl = TextEditingController();
  final kdbxService = KdbxService();

  Future<void> submitPassword() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final databaseUri = prefs.getString('database_uri');

      if (databaseUri == null) return;

      final database = await kdbxService.validatePassword(
        uri: databaseUri,
        password: pwdControl.text,
      );

      final rootGroup = kdbxService.readRootGroup(database);
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EnclaveHome(
            rootGroup: rootGroup,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect master password. Please try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    pwdControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: pwdControl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Enter Master Password",
              focusColor: Colors.amber,
            ),
          ),
          ElevatedButton(
            onPressed: submitPassword,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
