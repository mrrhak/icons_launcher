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
    CliLoggerLevel level = .one,
    String? emoji,
  }) {
    final space = _getSpace(level);
    print('\x1B[34m$space${emoji ?? '🌱'}  $message\x1B[0m');
  }

  /// Logs a error message at the given level.
  static void error(
    String message, {
    CliLoggerLevel level = .one,
    String? emoji,
  }) {
    final space = _getSpace(level);
    print('\x1B[31m$space${emoji ?? '❌'}  $message\x1B[0m');
  }

  /// Logs a warning message at the given level.
  static void warning(
    String message, {
    CliLoggerLevel level = .one,
    String? emoji,
  }) {
    final space = _getSpace(level);
    print('\x1B[33m$space${emoji ?? '🚧'}  $message\x1B[0m');
  }

  /// Logs a success message at the given level.
  static void success(
    String message, {
    CliLoggerLevel level = .one,
    String? emoji,
  }) {
    final space = _getSpace(level);
    print('\x1B[32m$space${emoji ?? '✅'}  $message\x1B[0m');
  }

  static String _getSpace(CliLoggerLevel level) {
    var space = '';
    switch (level) {
      case .one:
        space = '';
        break;
      case .two:
        space = '      ';
        break;
      case .three:
        space = '         ';
        break;
    }
    return space;
  }
}
