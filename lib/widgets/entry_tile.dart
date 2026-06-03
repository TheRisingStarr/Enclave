import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/models/entry_model.dart';

class EntryTile extends StatelessWidget {
  final EntryModel entry;
  const EntryTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(entry.title), subtitle: Text(entry.username));
  }
}
