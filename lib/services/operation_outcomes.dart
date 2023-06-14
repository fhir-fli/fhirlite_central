import 'package:fhir/r4.dart';

import '../src.dart';

void notifyMalformedRequest(String requestString, String atSign) {
  final OperationOutcome operationOutcome = _operationOutcome(
      'Incorrectly Formed Request',
      diagnostics: 'Unable to parse this string: $requestString',
      coding: [
        Coding(
          system: FhirUri('http://hl7.org/fhir/operation-outcome'),
          code: FhirCode('MSG_CANT_PARSE_CONTENT'),
          display: 'Unable to parse feed',
        ),
      ]);
  atNotify(operationOutcome.toJson(), atSign);
}

OperationOutcome _operationOutcome(
  String issue, {
  String? diagnostics,
  List<Coding>? coding,
}) =>
    OperationOutcome(
      issue: <OperationOutcomeIssue>[
        OperationOutcomeIssue(
          severity: FhirCode('error'),
          code: FhirCode('value'),
          details: CodeableConcept(
            text: issue,
            coding: coding,
          ),
          diagnostics: diagnostics,
        ),
      ],
    );
