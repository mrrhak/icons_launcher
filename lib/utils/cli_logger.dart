enum CliLoggerLevel {
  one,
  two,
  three,
}

class CliLogger {
  CliLogger();
  static void info(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('$space⚡  $message');
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
    print('$space⚠️  $message');
  }

  /// Logs a success message at the given level.
  static void success(
    String message, {
    CliLoggerLevel level = CliLoggerLevel.one,
  }) {
    final String space = _getSpace(level);
    print('$space✅  $message');
  }

  static String _getSpace(CliLoggerLevel level) {
    String space = '';
    switch (level) {
      case CliLoggerLevel.one:
        space = '';
        break;
      case CliLoggerLevel.two:
        space = '    ';
        break;
      case CliLoggerLevel.three:
        space = '       ';
        break;
    }
    return space;
  }
}
