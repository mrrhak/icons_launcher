part of icons_launcher_cli;

void _createWindowsIcons({required String imagePath}) {
  CliLogger.info('Creating Windows icons...');

  final image = decodeImage(File(imagePath).readAsBytesSync());
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final template =
      WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 128);
  _saveImageWindow(template, image, WINDOWS_DEFAULT_ICON_FILE_NAME);

  CliLogger.success(
    'Generated app icon image',
    level: CliLoggerLevel.two,
  );
}

void _saveImageWindow(
  WindowsIconTemplate template,
  Image image,
  String fileName,
) {
  final resizedImage = createResizedImage(template.size, image);
  final file = File('$WINDOWS_DEFAULT_ICON_DIR$fileName');
  file.createSync(recursive: true);
  file.writeAsBytesSync(encodeIco(resizedImage));
}
