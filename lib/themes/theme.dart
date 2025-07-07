import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff616118),
      surfaceTint: Color(0xff616118),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe8e78f),
      onPrimaryContainer: Color(0xff494900),
      secondary: Color(0xff755b0b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdf95),
      onSecondaryContainer: Color(0xff594400),
      tertiary: Color(0xff3e6837),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbff0b1),
      onTertiaryContainer: Color(0xff275021),
      error: Color(0xff8d4e29),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdbca),
      onErrorContainer: Color(0xff703714),
      surface: Color(0xfffbfaed),
      onSurface: Color(0xff1b1c15),
      onSurfaceVariant: Color(0xff46483c),
      outline: Color(0xff76786b),
      outlineVariant: Color(0xffc6c8b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffcbcb76),
      primaryFixed: Color(0xffe8e78f),
      onPrimaryFixed: Color(0xff1d1d00),
      primaryFixedDim: Color(0xffcbcb76),
      onPrimaryFixedVariant: Color(0xff494900),
      secondaryFixed: Color(0xffffdf95),
      onSecondaryFixed: Color(0xff251a00),
      secondaryFixedDim: Color(0xffe6c36c),
      onSecondaryFixedVariant: Color(0xff594400),
      tertiaryFixed: Color(0xffbff0b1),
      onTertiaryFixed: Color(0xff002201),
      tertiaryFixedDim: Color(0xffa4d397),
      onTertiaryFixedVariant: Color(0xff275021),
      surfaceDim: Color(0xffdbdbcf),
      surfaceBright: Color(0xfffbfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f4e8),
      surfaceContainer: Color(0xffefeee2),
      surfaceContainerHigh: Color(0xffe9e9dd),
      surfaceContainerHighest: Color(0xffe3e3d7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff383800),
      surfaceTint: Color(0xff616118),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff707026),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff453400),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff85691c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff163e12),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4d7744),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5b2705),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff9e5c36),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbfaed),
      onSurface: Color(0xff10120b),
      onSurfaceVariant: Color(0xff35372c),
      outline: Color(0xff515447),
      outlineVariant: Color(0xff6c6e61),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffcbcb76),
      primaryFixed: Color(0xff707026),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff57580e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff85691c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6a5100),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4d7744),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff355e2e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc7c7bc),
      surfaceBright: Color(0xfffbfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f4e8),
      surfaceContainer: Color(0xffe9e9dd),
      surfaceContainerHigh: Color(0xffdeddd1),
      surfaceContainerHighest: Color(0xffd2d2c6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2e2e00),
      surfaceTint: Color(0xff616118),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c4c01),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff392a00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5c4600),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0a3408),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff295223),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4d1e00),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff733a17),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbfaed),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2b2d22),
      outlineVariant: Color(0xff484a3e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffcbcb76),
      primaryFixed: Color(0xff4c4c01),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff343500),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5c4600),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff413000),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff295223),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff123b0f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb9b9ae),
      surfaceBright: Color(0xfffbfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f1e5),
      surfaceContainer: Color(0xffe3e3d7),
      surfaceContainerHigh: Color(0xffd5d5c9),
      surfaceContainerHighest: Color(0xffc7c7bc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbcb76),
      surfaceTint: Color(0xffcbcb76),
      onPrimary: Color(0xff323200),
      primaryContainer: Color(0xff494900),
      onPrimaryContainer: Color(0xffe8e78f),
      secondary: Color(0xffe6c36c),
      onSecondary: Color(0xff3e2e00),
      secondaryContainer: Color(0xff594400),
      onSecondaryContainer: Color(0xffffdf95),
      tertiary: Color(0xffa4d397),
      onTertiary: Color(0xff0f380c),
      tertiaryContainer: Color(0xff275021),
      onTertiaryContainer: Color(0xffbff0b1),
      error: Color(0xffffb68f),
      onError: Color(0xff532201),
      errorContainer: Color(0xff703714),
      onErrorContainer: Color(0xffffdbca),
      surface: Color(0xff13140d),
      onSurface: Color(0xffe3e3d7),
      onSurfaceVariant: Color(0xffc6c8b8),
      outline: Color(0xff909284),
      outlineVariant: Color(0xff46483c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d7),
      inversePrimary: Color(0xff616118),
      primaryFixed: Color(0xffe8e78f),
      onPrimaryFixed: Color(0xff1d1d00),
      primaryFixedDim: Color(0xffcbcb76),
      onPrimaryFixedVariant: Color(0xff494900),
      secondaryFixed: Color(0xffffdf95),
      onSecondaryFixed: Color(0xff251a00),
      secondaryFixedDim: Color(0xffe6c36c),
      onSecondaryFixedVariant: Color(0xff594400),
      tertiaryFixed: Color(0xffbff0b1),
      onTertiaryFixed: Color(0xff002201),
      tertiaryFixedDim: Color(0xffa4d397),
      onTertiaryFixedVariant: Color(0xff275021),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff393a32),
      surfaceContainerLowest: Color(0xff0d0f08),
      surfaceContainerLow: Color(0xff1b1c15),
      surfaceContainer: Color(0xff1f2019),
      surfaceContainerHigh: Color(0xff292b23),
      surfaceContainerHighest: Color(0xff34352d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe1e18a),
      surfaceTint: Color(0xffcbcb76),
      onPrimary: Color(0xff272700),
      primaryContainer: Color(0xff949546),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffdd87f),
      onSecondary: Color(0xff312400),
      secondaryContainer: Color(0xffac8d3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb9e9ab),
      onTertiary: Color(0xff032d03),
      tertiaryContainer: Color(0xff6f9c65),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd3be),
      onError: Color(0xff431900),
      errorContainer: Color(0xffc87f56),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdcdecd),
      outline: Color(0xffb2b3a4),
      outlineVariant: Color(0xff909283),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d7),
      inversePrimary: Color(0xff4a4b00),
      primaryFixed: Color(0xffe8e78f),
      onPrimaryFixed: Color(0xff121200),
      primaryFixedDim: Color(0xffcbcb76),
      onPrimaryFixedVariant: Color(0xff383800),
      secondaryFixed: Color(0xffffdf95),
      onSecondaryFixed: Color(0xff181000),
      secondaryFixedDim: Color(0xffe6c36c),
      onSecondaryFixedVariant: Color(0xff453400),
      tertiaryFixed: Color(0xffbff0b1),
      onTertiaryFixed: Color(0xff001600),
      tertiaryFixedDim: Color(0xffa4d397),
      onTertiaryFixedVariant: Color(0xff163e12),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff44453c),
      surfaceContainerLowest: Color(0xff070803),
      surfaceContainerLow: Color(0xff1d1e17),
      surfaceContainer: Color(0xff272921),
      surfaceContainerHigh: Color(0xff32332b),
      surfaceContainerHighest: Color(0xff3d3e36),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5f59b),
      surfaceTint: Color(0xffcbcb76),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc7c773),
      onPrimaryContainer: Color(0xff0c0c00),
      secondary: Color(0xffffeece),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe2bf69),
      onSecondaryContainer: Color(0xff110a00),
      tertiary: Color(0xffccfdbe),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa0cf93),
      onTertiaryContainer: Color(0xff000f00),
      error: Color(0xffffece4),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffb086),
      onErrorContainer: Color(0xff1a0600),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff0f1e1),
      outlineVariant: Color(0xffc2c4b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d7),
      inversePrimary: Color(0xff4a4b00),
      primaryFixed: Color(0xffe8e78f),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcbcb76),
      onPrimaryFixedVariant: Color(0xff121200),
      secondaryFixed: Color(0xffffdf95),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe6c36c),
      onSecondaryFixedVariant: Color(0xff181000),
      tertiaryFixed: Color(0xffbff0b1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d397),
      onTertiaryFixedVariant: Color(0xff001600),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff505148),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f2019),
      surfaceContainer: Color(0xff303129),
      surfaceContainerHigh: Color(0xff3b3c34),
      surfaceContainerHighest: Color(0xff46473f),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
