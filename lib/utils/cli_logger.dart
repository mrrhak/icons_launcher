/// Log levels
enum CliLoggerLevel {
  /// Level one
  one,

  /// Level two
  two,

  /// Level three
  three,
}

// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m

/// Cli Logger
class CliLogger {
  /// Constructor
  CliLogger();

  /// Log info
  static void info(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('\x1B[34m$space🌱  $message\x1B[0m');
  }

  /// Logs a error message at the given level.
  static void error(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('$space❌  $message');
  }

  /// Logs a warning message at the given level.
  static void warning(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('\x1B[33m$space🚧 $message\x1B[0m');
  }

  /// Logs a success message at the given level.
  static void success(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('\x1B[32m$space✅  $message\x1B[0m');
  }

  static String _getSpace(CliLoggerLevel level) {
    String space = '';
    switch (level) {
      case CliLoggerLevel.one:
        space = '';
        break;
      case CliLoggerLevel.two:
        space = '      ';
        break;
      case CliLoggerLevel.three:
        space = '         ';
        break;
    }
    return space;
  }
}
