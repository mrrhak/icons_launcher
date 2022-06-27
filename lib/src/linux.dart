part of icons_launcher_cli;

void _createLinuxIcons({required String imagePath}) {
  CliLogger.info('Creating Linux icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final template = LinuxIconTemplate(name: LINUX_DEFAULT_ICON_NAME, size: 256);
  _saveImageLinux(template, image, LINUX_DEFAULT_ICON_FILE_NAME);

  CliLogger.success('Generated app icon image', level: CliLoggerLevel.two);

  _createLinuxDesktopFile();
  CliLogger.success('Created desktop entry file', level: CliLoggerLevel.two);
}

void _saveImageLinux(
  LinuxIconTemplate template,
  Icon image,
  String fileName,
) {
  image.saveResizedPng(template.size, '$LINUX_DEFAULT_ICON_DIR$fileName');
}

void _createLinuxDesktopFile() {
  const String desktopFile = '''
[Desktop Entry]
Name=Flutter Linux App
Comment=Flutter Linux launcher icon
Exec=$LINUX_DEFAULT_ICON_NAME
Icon=$LINUX_DEFAULT_ICON_FILE_NAME
Terminal=false
Type=Application
Categories=Entertainment;
''';

  final file = File('$LINUX_DEFAULT_ICON_DIR$LINUX_DEFAULT_ICON_NAME.desktop');
  file.createSync(recursive: true);
  file.writeAsStringSync(desktopFile);
}
