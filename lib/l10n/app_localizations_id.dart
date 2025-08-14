// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get titleAppBar => 'Story App';

  @override
  String get loginButton => 'Masuk';

  @override
  String get registerButton => 'Daftar';

  @override
  String get logoutButton => 'Keluar';

  @override
  String get settingsButton => 'Pengaturan';

  @override
  String get namaLabel => 'Nama';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get confirmPasswordLabel => 'Konfirmasi Kata Sandi';

  @override
  String get hintNamaLabel => 'Masukkan nama Anda';

  @override
  String get hintEmailLabel => 'Masukkan email Anda';

  @override
  String get hintPasswordLabel => 'Masukkan kata sandi Anda';

  @override
  String get hintConfirmPasswordLabel => 'Konfirmasi kata sandi Anda';

  @override
  String get donthaveAccount => 'Belum punya akun?';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun?';

  @override
  String get errorLogin => 'Gagal masuk, silakan coba lagi.';

  @override
  String get errorRegister => 'Gagal mendaftar, silakan coba lagi.';

  @override
  String get namaRequired => 'Nama wajib diisi.';

  @override
  String get emailRequired => 'Email wajib diisi.';

  @override
  String get emailInvalid => 'Email tidak valid.';

  @override
  String get passwordRequired => 'Kata sandi minimal 8 karakter.';

  @override
  String get confirmPasswordRequired => 'Konfirmasi kata sandi wajib diisi.';

  @override
  String get passwordsDoNotMatch => 'Kata sandi tidak cocok.';

  @override
  String get areYouSure => 'Apakah Anda yakin ingin keluar?';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Batalkan';
}
