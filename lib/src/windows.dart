import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/icon.dart';
import 'package:icons_launcher/utils.dart';

/// File to handle the creation of icons for Windows platform
class WindowsIconTemplate {
  WindowsIconTemplate({required this.size, required this.name});

  final String name;
  final int size;
}

//? https://www.creativefreedom.co.uk/icon-designers-blog/windows-ico/
// Give a highest quality icon with a minimum of 256x256 pixels.
// debug ico file here (https://redketchup.io/icon-editor)
List<WindowsIconTemplate> windowsIcons = <WindowsIconTemplate>[
  WindowsIconTemplate(name: '', size: 16),
  WindowsIconTemplate(name: '', size: 24),
  WindowsIconTemplate(name: '', size: 32),
  WindowsIconTemplate(name: '', size: 48),
  WindowsIconTemplate(name: '', size: 64),
  WindowsIconTemplate(name: '', size: 96),
  WindowsIconTemplate(name: '', size: 128),
  WindowsIconTemplate(name: '', size: 256),
];

/// Overwrites the icon file with the new icon
void overwriteDefaultIcons(List<Icon> images) {
  Icon.saveIco(
    images,
    windowsDefaultIconFolder + windowsDefaultIconName + '.ico',
  );
}

/// Creates new icons
void saveNewIcons(List<Icon> images, String newIconName) {
  final String newIconFolder = windowsDefaultIconFolder + newIconName;
  Icon.saveIco(images, newIconFolder + newIconName + '.ico');
}

/// Create icons
void createIcons(Map<String, dynamic> config, String? flavor) {
  final String filePath = config['image_path_windows'] ?? config['image_path'];
  // decodeImageFile shows error message if null
  // so can return here if image is null
  final image = Icon.loadFile(filePath);
  if (image == null) {
    return;
  }

  final dynamic windowsConfig = config['windows'];
  if (windowsConfig is String) {
    // If the Windows configuration is a string then the user has specified a new icon to be created
    // and for the old icon file to be kept
    final String newIconName = windowsConfig;
    printStatus('Adding new Windows launcher icon');
    final images = <Icon>[];
    for (WindowsIconTemplate template in windowsIcons) {
      final resizedImage = image.copyResized(template.size);
      images.add(resizedImage);
    }
    saveNewIcons(images, newIconName);
  } else {
    printStatus('Overwriting default Windows launcher icon with new icon');
    final images = <Icon>[];
    for (WindowsIconTemplate template in windowsIcons) {
      final resizedImage = image.copyResized(template.size);
      images.add(resizedImage);
    }
    overwriteDefaultIcons(images);
  }
}
