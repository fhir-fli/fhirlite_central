import 'package:fhir/dstu2.dart' as dstu2;
import 'package:fhir_at_rest/dstu2.dart' as dstu2_request;
import 'package:fhir/r4.dart' as r4;
import 'package:fhir_at_rest/r4.dart' as r4_request;
import 'package:fhir/r5.dart' as r5;
import 'package:fhir_at_rest/r5.dart' as r5_request;
import 'package:fhir/stu3.dart' as stu3;
import 'package:fhir_at_rest/stu3.dart' as stu3_request;
import 'package:fhirlite_central/src.dart';

// TODO(Dokotela): add authentication headers
final Map<String, String> headers = <String, String>{};
const int numberOfTries = 8;
const List<int> _timeout = <int>[
  200,
  400,
  800,
  1600,
  3200,
  6400,
  12800,
  25600,
  51200,
];
Future<void> timeout(int i) async {
  await Future.delayed(Duration(milliseconds: _timeout[i]));
}

Future<dstu2.Resource> makeDstu2Request(
    dstu2_request.FhirRequest request) async {
  dstu2.Resource resource = dstu2OperationOutcome(
      "Unable to make request, sorry, that's all we know.");
  for (var i = 0; i < numberOfTries; i++) {
    resource = await request.request(headers: headers);
    if (resource is! dstu2.OperationOutcome ||
        (resource.issue.first.code.toString() != 'informational')) {
      return resource;
    } else {
      await timeout(i);
    }
  }
  return resource;
}

Future<r4.Resource> makeR4Request(r4_request.FhirRequest request) async {
  r4.Resource resource =
      r4OperationOutcome("Unable to make request, sorry, that's all we know.");
  for (var i = 0; i < numberOfTries; i++) {
    resource = await request.request(headers: headers);
    if (resource is! r4.OperationOutcome ||
        (resource.issue.first.code.toString() != 'informational')) {
      return resource;
    } else {
      await timeout(i);
    }
  }
  return resource;
}

Future<r5.Resource> makeR5Request(r5_request.FhirRequest request) async {
  r5.Resource resource =
      r5OperationOutcome("Unable to make request, sorry, that's all we know.");
  for (var i = 0; i < numberOfTries; i++) {
    resource = await request.request(headers: headers);
    if (resource is! r5.OperationOutcome ||
        (resource.issue.first.code.toString() != 'informational')) {
      return resource;
    } else {
      await timeout(i);
    }
  }
  return resource;
}

Future<stu3.Resource> makeStu3Request(stu3_request.FhirRequest request) async {
  stu3.Resource resource = stu3OperationOutcome(
      "Unable to make request, sorry, that's all we know.");
  for (var i = 0; i < numberOfTries; i++) {
    resource = await request.request(headers: headers);
    if (resource is! stu3.OperationOutcome ||
        (resource.issue.first.code.toString() != 'informational')) {
      return resource;
    } else {
      await timeout(i);
    }
  }
  return resource;
}
