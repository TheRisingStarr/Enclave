import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:enclave/models/entry_model.dart';
import 'package:flutter/services.dart';

class EntryPage extends StatefulWidget {
  final EntryModel entry;

  const EntryPage({
    super.key,
    required this.entry,
  });

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final colors = M3ETheme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,

      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(entry.title),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.key_rounded,
                    size: 48,
                    color: colors.onSecondaryContainer,
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  entry.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              'Credentials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.alternate_email_rounded,
                      color: colors.onSecondaryContainer,
                    ),
                    title: Text(
                      'Username',
                      style: TextStyle(color: colors.onSecondaryContainer),
                    ),
                    subtitle: Text(
                      entry.username,
                      style: TextStyle(color: colors.onSecondaryContainer),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy_rounded),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: entry.username),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: colors.onSecondaryContainer.withValues(alpha: 0.1),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.key_rounded,
                      color: colors.onSecondaryContainer,
                    ),
                    title: Text(
                      'Password',
                      style: TextStyle(color: colors.onSecondaryContainer),
                    ),
                    subtitle: Text(
                      showPassword
                          ? entry.password
                          : '•' * entry.password.length,
                      style: TextStyle(color: colors.onSecondaryContainer),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy_rounded),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: entry.password),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (entry.url.isNotEmpty) ...[
              const SizedBox(height: 28),
              Text(
                'Website',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                tileColor: colors.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(
                  Icons.language_rounded,
                  color: colors.onSecondaryContainer,
                ),
                title: Text(
                  entry.url,
                  style: TextStyle(
                    color: colors.onSecondaryContainer,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 28),

            Text(
              'Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                entry.notes.isEmpty ? 'No notes added yet.' : entry.notes,
                style: TextStyle(
                  color: colors.onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
