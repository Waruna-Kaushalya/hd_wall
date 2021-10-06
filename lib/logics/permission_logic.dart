import 'package:permission_handler/permission_handler.dart';

class PermissionCheckLogic {
  void checkPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        var status = await Permission.ignoreBatteryOptimizations.status;
        if (!status.isGranted) {
          var status = await Permission.ignoreBatteryOptimizations.request();
          if (status.isGranted) {
            //Good, all your permission are granted, do some stuff
          } else {
            //Do stuff according to this permission was rejected
          }
        }
      } else {
        //Do stuff according to this permission was rejected
      }
    }
  }
}
