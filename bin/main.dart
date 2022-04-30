import 'dart:async';
import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/main.dart' as icons_launcher;

void main(List<String> arguments) {
  print(introMessage);
  unawaited(icons_launcher.createIconsFromArguments(arguments));
}
