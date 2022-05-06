import 'dart:async';
import 'package:icons_launcher/main.dart' as icons_launcher;

void main(List<String> arguments) {
  unawaited(icons_launcher.createIconsFromArguments(arguments));
}
