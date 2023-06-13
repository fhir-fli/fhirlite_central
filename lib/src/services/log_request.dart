import 'package:at_fhir/at_fhir.dart';
import 'package:fhir_at_rest/r4.dart';

Future<SuccessOrError> logRequest(
  FhirRequest request,
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
    value: request.toJsonString(),
    sharedWith: atSign,
    nameSpace: nameSpace,
  );
}
