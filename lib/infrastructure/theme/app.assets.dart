
abstract class _CommonAssets {
  static const _LogoAssets logo = _LogoAssets();
}

class _LightIcons {
  static const String _iconsPath = 'assets/images';
  final splashScreen = '$_iconsPath/SplashScreen3.png';
  final backButton = '$_iconsPath/arrow_left_alt.png';
  final nextButton = '$_iconsPath/next-arrow.png';
}

class _LightAssets extends _CommonAssets {
  final icons = _LightIcons();
}

class _LogoAssets {
  const _LogoAssets();
}

abstract class AppAssets {
  static final light = _LightAssets();
}
