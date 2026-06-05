import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:enclave/models/entry_model.dart';
import 'package:enclave/widgets/entry_tile.dart';

class EnclaveHome extends StatefulWidget {
  const EnclaveHome({super.key});

  @override
  State<EnclaveHome> createState() => _EnclaveHomeState();
}

class _EnclaveHomeState extends State<EnclaveHome> {
  final List<EntryModel> entries = [
    EntryModel(
      uuid: 'demo-001',
      title: 'Google',
      username: 'alex.morgan@gmail.com',
      password: 'Demo_Google_123!',
      url: 'https://google.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-002',
      title: 'GitHub',
      username: 'alexmorgan',
      password: 'Demo_GitHub_456!',
      url: 'https://github.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-003',
      title: 'Microsoft',
      username: 'alex.morgan@outlook.com',
      password: 'Demo_Microsoft_789!',
      url: 'https://microsoft.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-004',
      title: 'Amazon',
      username: 'alex.morgan@email.com',
      password: 'Demo_Amazon_123!',
      url: 'https://amazon.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-005',
      title: 'Netflix',
      username: 'alex.morgan@email.com',
      password: 'Demo_Netflix_456!',
      url: 'https://netflix.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-006',
      title: 'Spotify',
      username: 'alexmorgan',
      password: 'Demo_Spotify_789!',
      url: 'https://spotify.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-007',
      title: 'Discord',
      username: 'alex_morgan',
      password: 'Demo_Discord_123!',
      url: 'https://discord.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-008',
      title: 'Reddit',
      username: 'u/alexmorgan',
      password: 'Demo_Reddit_456!',
      url: 'https://reddit.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-009',
      title: 'Instagram',
      username: '@alex.morgan',
      password: 'Demo_Insta_789!',
      url: 'https://instagram.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-010',
      title: 'Facebook',
      username: 'alex.morgan@email.com',
      password: 'Demo_Facebook_123!',
      url: 'https://facebook.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-011',
      title: 'Twitter / X',
      username: '@alexmorgan',
      password: 'Demo_Twitter_456!',
      url: 'https://x.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-012',
      title: 'LinkedIn',
      username: 'alex.morgan@email.com',
      password: 'Demo_LinkedIn_789!',
      url: 'https://linkedin.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-013',
      title: 'Dropbox',
      username: 'alex.morgan@email.com',
      password: 'Demo_Dropbox_123!',
      url: 'https://dropbox.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-014',
      title: 'Proton Mail',
      username: 'alex@proton.me',
      password: 'Demo_Proton_456!',
      url: 'https://proton.me',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-015',
      title: 'Cloudflare',
      username: 'alex.morgan@email.com',
      password: 'Demo_Cloudflare_789!',
      url: 'https://cloudflare.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-016',
      title: 'Notion',
      username: 'alex.morgan@email.com',
      password: 'Demo_Notion_123!',
      url: 'https://notion.so',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-017',
      title: 'Steam',
      username: 'alexmorgan',
      password: 'Demo_Steam_456!',
      url: 'https://store.steampowered.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-018',
      title: 'PlayStation Network',
      username: 'alexmorgan',
      password: 'Demo_PS_789!',
      url: 'https://playstation.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-019',
      title: 'Twitch',
      username: 'alexmorgan',
      password: 'Demo_Twitch_123!',
      url: 'https://twitch.tv',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-020',
      title: 'PayPal',
      username: 'alex.morgan@email.com',
      password: 'Demo_PayPal_456!',
      url: 'https://paypal.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-021',
      title: 'Canva',
      username: 'alex.morgan@email.com',
      password: 'Demo_Canva_789!',
      url: 'https://canva.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-022',
      title: 'Figma',
      username: 'alex.morgan@email.com',
      password: 'Demo_Figma_123!',
      url: 'https://figma.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-023',
      title: 'Adobe',
      username: 'alex.morgan@email.com',
      password: 'Demo_Adobe_456!',
      url: 'https://adobe.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-024',
      title: 'YouTube',
      username: 'alex.morgan@gmail.com',
      password: 'Demo_YouTube_789!',
      url: 'https://youtube.com',
      notes: '',
    ),
    EntryModel(
      uuid: 'demo-025',
      title: 'GitLab',
      username: 'alexmorgan',
      password: 'Demo_GitLab_123!',
      url: 'https://gitlab.com',
      notes: '',
    ),
  ];

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
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return EntryTile(entry: entries[index]);
        },
      ),
    );
  }
}
