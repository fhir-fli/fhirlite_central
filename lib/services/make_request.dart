import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';

Future<Resource> makeRequest(FhirRequest request, String atSign) async {
  // TODO(Dokotela): add authentication headers
  final Map<String, String> headers = <String, String>{};
  return await request.request(headers: headers);
}
