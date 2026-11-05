import 'package:enclave/screens/entries_screen.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/widgets/entry_tile.dart';
import 'package:enclave/models/group_model.dart';
import 'package:enclave/widgets/group_tile.dart';
import 'package:enclave/models/entry_model.dart';

class EnclaveHome extends StatefulWidget {
  final GroupModel rootGroup;
  final GroupModel? currentGroup;

  const EnclaveHome({
    super.key,
    required this.rootGroup,
    this.currentGroup,
  });

  @override
  State<EnclaveHome> createState() => _EnclaveHomeState();
}

class _EnclaveHomeState extends State<EnclaveHome> {
  String _sortOrder = 'Name (A–Z)';
  bool _showFolders = true;
  List<EntryModel> getAllEntries(GroupModel group) {
    return [
      ...group.entries,
      ...group.groups.expand(getAllEntries),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = M3ETheme.of(context).colorScheme;
    final group = widget.currentGroup ?? widget.rootGroup;
    final sortedGroups = [...group.groups]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final sortedEntries = _showFolders
        ? [...group.entries]
        : getAllEntries(widget.rootGroup);

    sortedEntries.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );

    if (_sortOrder == 'Name (Z–A)') {
      sortedGroups.setAll(0, sortedGroups.reversed);
      sortedEntries.setAll(0, sortedEntries.reversed);
    }

    final visibleGroups = _showFolders ? sortedGroups : [];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,

        title: const Text('Enclave'),

        titleTextStyle: TextStyle(
          fontFamily: 'GoogleSansFlex',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
          height: 1.1,
          color: colors.onSurface,
          fontVariations: const [
            FontVariation('opsz', 80),
            FontVariation('wdth', 400),
            FontVariation('GRAD', 40),
            FontVariation('ROND', 20),
          ],
        ),

        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        actions: [
          Container(
            height: 46,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Search',
                  onPressed: () {},
                  color: colors.onSurfaceVariant,
                  icon: const Icon(Icons.search_rounded),
                ),

                MenuAnchor(
                  menuChildren: [
                    SubmenuButton(
                      leadingIcon: const Icon(Icons.sort_rounded),
                      menuChildren: [
                        MenuItemButton(
                          trailingIcon: _sortOrder == 'Name (A–Z)'
                              ? const Icon(Icons.check)
                              : null,
                          onPressed: () {
                            setState(() {
                              _sortOrder = 'Name (A–Z)';
                            });
                          },
                          child: const Text('Name (A–Z)'),
                        ),

                        MenuItemButton(
                          trailingIcon: _sortOrder == 'Name (Z–A)'
                              ? const Icon(Icons.check)
                              : null,
                          onPressed: () {
                            setState(() {
                              _sortOrder = 'Name (Z–A)';
                            });
                          },
                          child: const Text('Name (Z–A)'),
                        ),
                      ],
                      child: const Text('Sort by'),
                    ),

                    MenuItemButton(
                      leadingIcon: const Icon(Icons.folder_outlined),
                      trailingIcon: _showFolders
                          ? const Icon(Icons.check)
                          : null,
                      onPressed: () {
                        setState(() {
                          _showFolders = !_showFolders;
                        });
                      },
                      child: const Text('Show folders'),
                    ),
                  ],
                  builder: (context, controller, child) {
                    return IconButton(
                      tooltip: 'More options',
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      color: colors.onSurfaceVariant,
                      icon: const Icon(Icons.more_vert_rounded),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: visibleGroups.length + sortedEntries.length,
        itemBuilder: (context, index) {
          if (index < visibleGroups.length) {
            final childGroup = visibleGroups[index];

            return GroupTile(
              group: childGroup,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnclaveHome(
                      rootGroup: widget.rootGroup,
                      currentGroup: childGroup,
                    ),
                  ),
                );
              },
            );
          }

          final entry = sortedEntries[index - visibleGroups.length];

          return EntryTile(
            entry: entry,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntryPage(entry: entry),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
