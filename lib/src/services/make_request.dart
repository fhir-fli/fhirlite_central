import 'package:fhir_at_rest/r4.dart';
import '../src.dart';

Future<void> makeRequest(FhirRequest request, String atSign) async {
  // TODO(Dokotela): add authentication headers
  final Map<String, String> headers = <String, String>{};
  final result = await request.request(headers: headers);
  notify(result.toJson(), atSign);
}
