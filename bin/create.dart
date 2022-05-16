import 'dart:async';
import 'package:icons_launcher/main.dart' as icons_launcher;

/// Run to create launcher icons
void main(List<String> arguments) {
  unawaited(icons_launcher.createIconsFromArguments(arguments));
}
