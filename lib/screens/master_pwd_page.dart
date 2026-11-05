import 'package:enclave/screens/homepage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:enclave/services/kdbx_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterPwdPage extends StatefulWidget {
  const MasterPwdPage({super.key});

  @override
  State<MasterPwdPage> createState() => _MasterPwdPageState();
}

class _MasterPwdPageState extends State<MasterPwdPage> {
  final TextEditingController pwdControl = TextEditingController();
  final KdbxService kdbxService = KdbxService();

  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    pwdControl.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    setState(() {});
  }

  Future<void> submitPassword() async {
    if (isLoading || pwdControl.text.trim().isEmpty) return;

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final databaseUri = prefs.getString('database_uri');

      if (databaseUri == null) {
        throw Exception('Database URI not found.');
      }

      final database = await kdbxService.validatePassword(
        uri: databaseUri,
        password: pwdControl.text,
      );

      final rootGroup = kdbxService.readRootGroup(database);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EnclaveHome(
            rootGroup: rootGroup,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.08, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Incorrect master password. Please try again.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    pwdControl.removeListener(_onPasswordChanged);
    pwdControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final hasPassword = pwdControl.text.trim().isNotEmpty;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enclave',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.2,
                      ),
                    ),

                    Text(
                      'Your secure vault, all in one place.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 36),

                    TextField(
                      controller: pwdControl,
                      obscureText: obscurePassword,
                      enabled: !isLoading,
                      onSubmitted: (_) {
                        if (hasPassword && !isLoading) {
                          submitPassword();
                        }
                      },
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        hintText: "Enter your master password",
                        prefixIcon: const Icon(Icons.key_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        ),
                        filled: true,
                        fillColor: colors.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primary,
                        ),
                        onPressed: !hasPassword || isLoading
                            ? null
                            : submitPassword,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isLoading
                              ? const M3ELoadingIndicator(
                                  key: ValueKey('loading'),
                                  size: 32,
                                )
                              : const Row(
                                  key: ValueKey('unlock'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock_open_rounded),
                                    SizedBox(width: 10),
                                    Text('Unlock'),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
