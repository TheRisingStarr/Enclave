import 'package:enclave/screens/file_selector.dart';
import 'package:enclave/screens/master_pwd_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  Future<void> checkDatabaseAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final uri = prefs.getString('database_uri');

    if (!mounted) return;

    if (uri != null && uri.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MasterPwdPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FileSelector()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkDatabaseAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
