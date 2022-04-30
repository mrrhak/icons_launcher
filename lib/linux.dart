import 'dart:io';

import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/utils.dart';
import 'package:image/image.dart';

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

/// Create the resized icons
Image createResizedImage(LinuxIconTemplate template, Image image) {
  if (image.width >= template.size) {
    return copyResize(
      image,
      width: template.size,
      height: template.size,
      interpolation: Interpolation.average,
    );
  } else {
    return copyResize(
      image,
      width: template.size,
      height: template.size,
      interpolation: Interpolation.linear,
    );
  }
}

/// Override the default icon
void overwriteDefaultIcons(LinuxIconTemplate template, Image image) {
  final Image newFile = createResizedImage(template, image);
  File(linuxDefaultIconFolder + template.name + '.png')
    ..writeAsBytesSync(encodeIco(newFile));
}

/// Save the icons
void saveNewIcons(LinuxIconTemplate template, Image image,
    {String? newIconName}) {
  final Image newFile = createResizedImage(template, image);
  final iconName = newIconName ?? template.name;
  File(linuxDefaultIconFolder + iconName + '.png')
      .create(recursive: true)
      .then((File file) {
    file.writeAsBytesSync(encodeIco(newFile));
  });
}

/// Create the icons
void createIcons(Map<String, dynamic> config, String? flavor) {
  final String filePath = config['image_path_linux'] ?? config['image_path'];
  // decodeImageFile shows error message if null
  // so can return here if image is null
  final Image? image = decodeImage(File(filePath).readAsBytesSync());
  if (image == null) {
    return;
  }

  final dynamic linuxConfig = config['linux'];
  if (flavor != null) {
    final String catalogName = 'AppIcon-$flavor';
    printStatus('Building Linux icon launcher for $flavor');
    for (LinuxIconTemplate template in linuxIcons) {
      saveNewIcons(template, image, newIconName: catalogName);
    }
  } else if (linuxConfig is String) {
    // If the Linux configuration is a string then the user has specified a new icon to be created
    // and for the old icon file to be kept
    final String newIconName = linuxConfig;
    printStatus('Adding new linux icon launcher');
    for (LinuxIconTemplate template in linuxIcons) {
      saveNewIcons(template, image, newIconName: newIconName);
    }
  } else {
    printStatus('Adding new linux icon launcher');
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
Comment=Flutter Linux Icon Launcher
Exec=$linuxDefaultIconName
Icon=$linuxDefaultIconName.png
Terminal=false
Type=Application
Categories=Entertainment;
''';
  File(linuxDefaultIconFolder + linuxDefaultIconName + '.desktop')
      .writeAsStringSync(desktopFile);
}
