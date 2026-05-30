import "package:enclave/screens/startup_page.dart";
import "package:material_ui/material_ui.dart";
import "package:material_3_expressive/material_3_expressive.dart";

void main() {
  runApp(const EnclaveApp());
}

class EnclaveApp extends StatelessWidget {
  const EnclaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return M3EMaterialApp(
      data: M3EThemeData(),
      fontFamily: 'GoogleSansFlex',

      home: StartupPage(),
    );
  }
}
