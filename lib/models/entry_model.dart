class EntryModel {
  final String uuid;
  final String title;
  final String username;
  final String password;
  final String url;
  final String notes;

  final String? totpSecret;
  final String totpAlgorithm;
  final int totpDigits;
  final int totpPeriod;

  const EntryModel({
    required this.uuid,
    required this.title,
    required this.username,
    required this.password,
    required this.url,
    required this.notes,
    this.totpSecret,
    this.totpAlgorithm = 'SHA1',
    this.totpDigits = 6,
    this.totpPeriod = 30,
  });
}
