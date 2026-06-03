import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/models/entry_model.dart';
import 'package:enclave/widgets/entry_tile.dart';

class EnclaveHome extends StatelessWidget {
  final List<EntryModel> entries;

  const EnclaveHome({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: M3EAppBar.top(
        titleText: "Enclave",
        variant: M3EAppBarVariant.mediumFlexible,
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return EntryTile(entry: entries[index]);
        },
      ),
    );
  }
}
