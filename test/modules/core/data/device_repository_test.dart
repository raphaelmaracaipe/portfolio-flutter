import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

import 'device_repository_test.mocks.dart';

class DeviceSPMock extends Mock implements DeviceSP {}

class RegexMock extends Mock implements Regex {}

@GenerateMocks([
  DeviceSPMock,
  RegexMock,
])
void main() {
  final MockDeviceSPMock deviceSPMock = MockDeviceSPMock();
  final MockRegexMock regexMock = MockRegexMock();

  test(
    'when already deviceId saved',
    () async {
      when(deviceSPMock.getDeviceID()).thenAnswer((_) async => "test");

      DeviceRepository deviceRepository = DeviceRepositoryImpl(
        deviceSP: deviceSPMock,
        regex: regexMock,
      );

      try {
        final deviceIdSaved = await deviceRepository.getID();
        expect("test", deviceIdSaved);
      } on Exception catch (_) {
        expect(true, false);
      }
    },
  );

  test(
    'when not saved and generated new',
    () async {
      when(deviceSPMock.getDeviceID()).thenAnswer((_) async => "");
      when(deviceSPMock.save(any)).thenAnswer((_) async {});
      when(regexMock.generateString(
        regexPattern: anyNamed("regexPattern"),
      )).thenAnswer(
        (_) async => "test",
      );

      DeviceRepository deviceRepository = DeviceRepositoryImpl(
        deviceSP: deviceSPMock,
        regex: regexMock,
      );

      try {
        final deviceIdSaved = await deviceRepository.getID();
        expect("test", deviceIdSaved);
      } on Exception catch (_) {
        expect(true, false);
      }
    },
  );
}
