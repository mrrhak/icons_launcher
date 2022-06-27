part of icons_launcher_cli;

void _createWindowsIcons({required String imagePath}) {
  CliLogger.info('Creating Windows icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  //? https://www.creativefreedom.co.uk/icon-designers-blog/windows-ico/
// Give a highest quality icon with a minimum of 256x256 pixels.
// debug ico file here (https://redketchup.io/icon-editor)
  final List<WindowsIconTemplate> windowsIcons = <WindowsIconTemplate>[
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 16),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 24),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 32),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 48),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 64),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 96),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 128),
    WindowsIconTemplate(name: WINDOWS_DEFAULT_ICON_NAME, size: 256),
  ];

  final images = <Icon>[];
  for (final template in windowsIcons) {
    final resizedImage = image.copyResized(template.size);
    images.add(resizedImage);
  }
  _saveImageWindow(images, WINDOWS_DEFAULT_ICON_FILE_NAME);

  CliLogger.success(
    'Generated app icon image',
    level: CliLoggerLevel.two,
  );
}

void _saveImageWindow(
  List<Icon> images,
  String fileName,
) {
  Icon.saveIco(images, '$WINDOWS_DEFAULT_ICON_DIR$fileName');
}
