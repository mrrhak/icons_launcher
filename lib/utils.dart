/// Logging
void printStatus(String message) {
  print('🚀 $message');
}

/// Generate error
String generateError(Exception e, String? error) {
  final errorOutput = error == null ? '' : ' \n$error';
  return '\n✗ ERROR: ${(e).runtimeType.toString()}$errorOutput';
}
