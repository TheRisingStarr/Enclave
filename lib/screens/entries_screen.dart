import 'dart:async';

import 'package:enclave/models/entry_model.dart';
import 'package:enclave/services/totp_service.dart';
import 'package:flutter/services.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

class EntryPage extends StatefulWidget {
  final EntryModel entry;
  const EntryPage({
    super.key,
    required this.entry,
  });

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;
  final TotpService _totpService = TotpService();
  bool showPassword = false;
  Timer? _totpTimer;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    if (widget.entry.totpSecret?.isNotEmpty == true) {
      _progressController.repeat();
      _totpTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (mounted) {
            setState(() {});
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _totpTimer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

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
                  if (entry.totpSecret?.isNotEmpty == true) ...[
                    Divider(
                      height: 1,
                      color: colors.onSecondaryContainer.withValues(alpha: 0.1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: _totpService.generateCode(entry)!,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    _totpService.generateCode(entry)!,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 6,
                                      color: colors.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  '${_totpService.remainingSeconds(entry)}s',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: colors.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, _) {
                              const periodMs = 30000;
                              final elapsedMs =
                                  DateTime.now().millisecondsSinceEpoch %
                                  periodMs;
                              return M3EProgressIndicator.linearWavy(
                                color: colors.primary,
                                amplitude: 3,
                                value: elapsedMs / periodMs,
                                strokeWidth: 6,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
