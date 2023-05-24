import 'package:at_client/at_client.dart';
import 'package:path_provider/path_provider.dart';

Future<AtClientPreference> loadAtClientPreference() async {
  var dir = await getApplicationSupportDirectory();

  return AtClientPreference()
    ..rootDomain = 'root.atsign.org'
    ..namespace = 'at_skeleton_app'
    ..hiveStoragePath = dir.path
    ..commitLogPath = dir.path
    ..isLocalStoreRequired = true;
  // TODO
  // * By default, this configuration is suitable for most applications
  // * In advanced cases you may need to modify [AtClientPreference]
  // * Read more here: https://pub.dev/documentation/at_client/latest/at_client/AtClientPreference-class.html
}
