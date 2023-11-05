import 'package:portfolio_flutter/modules/core/const/regex_const.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  final DeviceSP deviceSP;
  final Regex regex;

  DeviceRepositoryImpl({required this.deviceSP, required this.regex});

  @override
  Future<String> getID() async {
    final deviceIdSaved = await deviceSP.getDeviceID();
    if (deviceIdSaved.isEmpty) {
      final deviceIdGenerated = await regex.generateString(
        regexPattern: regexDeviceId,
      );

      deviceSP.save(deviceIdGenerated);
      return deviceIdGenerated;
    }
    return deviceIdSaved;
  }
}
