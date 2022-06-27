import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/utils.dart';
import 'package:universal_io/io.dart';

import '../icon.dart';

/// File to handle the creation of icons for Linux platform
class LinuxIconTemplate {
  LinuxIconTemplate({required this.size, required this.name});

  final String name;
  final int size;
}

/// List of icons to create
List<LinuxIconTemplate> linuxIcons = <LinuxIconTemplate>[
  LinuxIconTemplate(name: linuxDefaultIconName, size: 256),
];

///

/// Save the icons
void saveNewIcons(LinuxIconTemplate template, Icon image,
    {String? newIconName}) {
  final iconName = newIconName ?? template.name;
  final filePath = linuxDefaultIconFolder + iconName + '.png';

  image.saveResizedPng(template.size, filePath);
}

/// Create the icons
void createIcons(Map<String, dynamic> config, String? flavor) {
  final String filePath = config['image_path_linux'] ?? config['image_path'];
  // decodeImageFile shows error message if null
  // so can return here if image is null
  final image = Icon.loadFile(filePath);
  if (image == null) {
    return;
  }

  final dynamic linuxConfig = config['linux'];
  if (flavor != null) {
    final String catalogName = 'AppIcon-$flavor';
    printStatus('Building Linux launcher icon for $flavor');
    for (LinuxIconTemplate template in linuxIcons) {
      saveNewIcons(template, image, newIconName: catalogName);
    }
  } else if (linuxConfig is String) {
    // If the Linux configuration is a string then the user has specified a new icon to be created
    // and for the old icon file to be kept
    final String newIconName = linuxConfig;
    printStatus('Adding new linux launcher icon');
    for (LinuxIconTemplate template in linuxIcons) {
      saveNewIcons(template, image, newIconName: newIconName);
    }
  } else {
    printStatus('Adding new linux launcher icon');
    for (LinuxIconTemplate template in linuxIcons) {
      saveNewIcons(template, image);
    }
  }
  createDesktopFile();
}

/// Create the .desktop extension file
void createDesktopFile() {
  const String desktopFile = '''
[Desktop Entry]
Name=Flutter Linux App
Comment=Flutter Linux launcher icon
Exec=$linuxDefaultIconName
Icon=$linuxDefaultIconName.png
Terminal=false
Type=Application
Categories=Entertainment;
''';

  File(linuxDefaultIconFolder + linuxDefaultIconName + '.desktop')
      .create(recursive: true)
      .then((File file) {
    file.writeAsStringSync(desktopFile);
  });
}
