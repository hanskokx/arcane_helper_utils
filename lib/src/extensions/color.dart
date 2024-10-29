import "package:pure_dart_ui/pure_dart_ui.dart";

/// A collection of extensions for the `Color` class.
extension ColorsExtensions on Color {
  /// Determines if the color is considered dark.
  ///
  /// A color is considered dark if its luminance is less than 0.5.
  bool get isDark {
    final luminance = computeLuminance();
    // Luminance values range from 0 to 1, where 0 is black and 1 is white.
    // A luminance value below 0.5 indicates a dark color.
    return luminance < 0.5;
  }
}
