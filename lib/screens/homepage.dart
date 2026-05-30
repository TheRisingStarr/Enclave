import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/services/file_service.dart';

class EnclaveHome extends StatelessWidget {
  const EnclaveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: M3EAppBar.top(
        titleText: "Enclave",

        variant: M3EAppBarVariant.mediumFlexible,
      ),
      body: Center(
        child: ElevatedButton(onPressed: selectDatabase, child: Text("press")),
      ),
    );
  }
}
