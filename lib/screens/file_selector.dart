import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import 'package:enclave/screens/master_pwd_page.dart';
import 'package:enclave/services/file_service.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({super.key});

  Future<void> _selectDatabase(BuildContext context) async {
    final selected = await selectDatabase();

    if (!selected || !context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MasterPwdPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = M3ETheme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              Container(
                width: 144,
                height: 144,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(44),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  size: 76,
                  color: colors.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 36),

              Text(
                'Your digital vault.',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              Text(
                'Your passwords belong to you. '
                'Open your KeePass database to securely '
                'access your credentials.',
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 2),

              // Database selection
              SizedBox(
                width: double.infinity,
                child: M3EButton(
                  style: M3EButtonStyle.filled,
                  onPressed: () => _selectDatabase(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open_rounded),
                      SizedBox(width: 12),
                      Text('Open database'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 16,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your vault. Your privacy.',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
