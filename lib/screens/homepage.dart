import 'package:enclave/screens/entries_screen.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/models/entry_model.dart';
import 'package:enclave/widgets/entry_tile.dart';

class EnclaveHome extends StatefulWidget {
  const EnclaveHome({super.key, required this.entries});
  final List<EntryModel> entries;

  @override
  State<EnclaveHome> createState() => _EnclaveHomeState();
}

class _EnclaveHomeState extends State<EnclaveHome> {
  @override
  Widget build(BuildContext context) {
    final theme = M3ETheme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text('Enclave'),
        titleTextStyle: const TextStyle(
          fontFamily: 'GoogleSansFlex',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
          height: 1.1,
          color: Colors.black,
          fontVariations: [
            FontVariation('opsz', 80),
            FontVariation('wdth', 400),
            FontVariation('GRAD', 40),
            FontVariation('ROND', 20),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Container(
            height: 46,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Search',
                  onPressed: () {},
                  color: colors.onPrimaryContainer,
                  icon: const Icon(Icons.search_rounded),
                ),
                IconButton(
                  tooltip: 'Settings',
                  onPressed: () {},
                  color: colors.onPrimaryContainer,
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 24,
        ),
        itemCount: widget.entries.length,
        itemBuilder: (context, index) {
          final entry = widget.entries[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntryPage(entry: entry),
                ),
              );
            },
            child: EntryTile(
              entry: entry,
            ),
          );
        },
      ),
    );
  }
}
