import 'dart:developer';

import 'package:at_client/at_client.dart';
import 'package:at_fhir/at_fhir.dart';

import 'services/services.dart';

void listen(AtClientManager atClientManager) async {
  atClientManager.atClient.notificationService
      .subscribe(shouldDecrypt: true)
      .listen((atNotification) async {
    try {
      /// Make log of every request
      final logged = await logNotification(
        atClientManager.atClient,
        atNotification.value,
        atNotification.from,
      );

      /// Log the log (how meta! ;-) if it fails
      if (logged is! SuccessNotError) {
        log(logged.toString());
      }

      final AtFhirNotification atFhirNotification =
          AtFhirNotification.fromJsonString(
              atNotification.key.replaceFirst('@81xerothermic:', ''));
      switch (atFhirNotification) {
        case Dstu2ResourceNotification():
          {
            print('Dstu2ResourceNotification ${atFhirNotification.toJson()}');
          }
          break;
        case Stu3ResourceNotification():
          {
            print('Stu3ResourceNotification ${atFhirNotification.toJson()}');
          }
          break;
        case R4ResourceNotification():
          {
            print('R4ResourceNotification ${atFhirNotification.toJson()}');
          }
          break;
        case R5ResourceNotification():
          {
            print('R5ResourceNotification ${atFhirNotification.toJson()}');
          }
          break;
        case Dstu2Request():
          {
            print('Dstu2Request ${atFhirNotification.toJson()}');
          }
          break;
        case Stu3Request():
          {
            print('Stu3Request ${atFhirNotification.toJson()}');
          }
          break;
        case R4Request():
          {
            print('R4Request ${atFhirNotification.toJson()}');
            final patient = await atFhirNotification.value.request();
            print('PATIENT: ${patient.toJson()}');
          }
          break;
        case R5Request():
          {
            print('R5Request ${atFhirNotification.toJson()}');
          }
          break;
      }
    } catch (e, st) {
      log('Unable to parse request', error: e, stackTrace: st);
    }
  });
}
