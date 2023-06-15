import 'package:at_fhir/at_fhir.dart';

Future<SuccessOrError> logNotification(
  String? notification,
  String atSign, [
  String? nameSpace = 'fhir',
]) async {
  final now = DateTime.now()
      .toIso8601String()
      .replaceAll('T', '')
      .replaceAll(' ', '')
      .replaceAll(':', '')
      .replaceAll('-', '')
      .substring(0, 16);

  return await atSignPut(
    atKey: 'fhir.request.$now',
    value: notification ?? '',
    sharedWith: atSign,
    nameSpace: nameSpace,
  );
}
