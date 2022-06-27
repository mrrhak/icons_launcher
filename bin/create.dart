import 'package:args/args.dart';
import 'package:icons_launcher/cli_commands.dart';
import 'package:icons_launcher/utils/constants.dart';

/// Run to create launcher icons
void main(List<String> arguments) {
  print(START_MESSAGE);
  final parser = ArgParser();

  parser.addOption('path');
  parser.addOption('flavor');

  final parsedArgs = parser.parse(arguments);

  createLauncherIcons(path: parsedArgs['path'], flavor: parsedArgs['flavor']);
  print(END_MESSAGE);
}
