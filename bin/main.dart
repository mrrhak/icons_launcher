import 'dart:async';
import 'package:icons_launcher/main.dart' as icons_launcher;

/// Run the main app
void main(List<String> arguments) {
  // Start creating icons
  unawaited(icons_launcher.createIconsFromArguments(arguments));
}
