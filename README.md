# Enclave

**A private, offline-first password manager for Android.**

Enclave is a Flutter-based password manager designed to work directly with existing KeePass databases. It keeps your credentials in a familiar, portable `.kdbx` file rather than locking them into a proprietary cloud service.

## Features

- **KeePass compatibility** — Open existing `.kdbx` password databases.
- **Offline-first** — Access your credentials without an internet connection.
- **Credential overview** — View entry titles and usernames in a clean, modern interface.
- **Material 3 Expressive design** — A dynamic, adaptive interface inspired by Android's visual language.

## Security and privacy

Enclave is designed around local data ownership.

- Your password database remains a KeePass `.kdbx` file.
- The app does not require an online account.
- Your master password is not stored in app preferences.
- Your database is accessed through Android's document picker.

Enclave currently focuses on opening and reading existing databases. Editing and saving database changes are planned for future development.

## Current limitations

The project is under active development. Not all planned functionality is available yet.

- Adding, editing, and deleting entries are not implemented.
- Group and nested-group navigation is planned.
- TOTP authenticator support is planned.
- Service icons and additional entry details are planned.
- Database creation and other advanced database-management features are not yet implemented.

## Technology

- **Flutter** — Cross-platform UI framework, with Android as the current target.
- **Dart** — Application language.
- **KeePass KDBX** — Password database format.
- **Material 3 Expressive** — Interface and theming.
- **Android Storage Access Framework** — User-selected database access.
- **SharedPreferences** — Persisting the selected database URI.
