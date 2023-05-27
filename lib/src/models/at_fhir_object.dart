import 'dart:convert';

import 'package:fhir/dstu2.dart' as dstu2;
import 'package:fhir/r4.dart' as r4;
import 'package:fhir/r5.dart' as r5;
import 'package:fhir/stu3.dart' as stu3;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'at_fhir_object.freezed.dart';

@freezed
class AtFhirObject with _$AtFhirObject {
  const AtFhirObject._();

  const factory AtFhirObject({
    required String atKey,
    required String atFhirResource,
    required bool isOperationOutcome,
  }) = _AtFhirObject;

  factory AtFhirObject.dstu2(dstu2.Resource resource) {
    dstu2.Resource newResource;
    if (resource.resourceType == null) {
      newResource = dstu2.OperationOutcome(
        contained: [resource],
        issue: [
          dstu2.OperationOutcomeIssue(
              severity: dstu2.IssueSeverity.error,
              code: dstu2.FhirCode('structure'),
              details: dstu2.CodeableConcept(
                text:
                    'No resourceType was present in the resource contained in this OperationOutcome',
              )),
        ],
      ).newId();
    } else if (resource.fhirId == null) {
      newResource = resource.newId();
    } else {
      newResource = resource;
    }

    return AtFhirObject(
      atKey:
          'fhir.dstu2.${newResource.resourceTypeString!}.${newResource.fhirId}',
      atFhirResource: jsonEncode(newResource.toJson()),
      isOperationOutcome: resource is dstu2.OperationOutcome,
    );
  }

  factory AtFhirObject.stu3(stu3.Resource resource) {
    stu3.Resource newResource;
    if (resource.resourceType == null) {
      newResource = stu3.OperationOutcome(
        contained: [resource],
        issue: [
          stu3.OperationOutcomeIssue(
              severity: stu3.OperationOutcomeIssueSeverity.error,
              code: stu3.OperationOutcomeIssueCode.structure,
              details: stu3.CodeableConcept(
                text:
                    'No resourceType was present in the resource contained in this OperationOutcome',
              )),
        ],
      ).newId();
    } else if (resource.fhirId == null) {
      newResource = resource.newId();
    } else {
      newResource = resource;
    }

    return AtFhirObject(
      atKey:
          'fhir.stu3.${newResource.resourceTypeString!}.${newResource.fhirId}',
      atFhirResource: jsonEncode(newResource.toJson()),
      isOperationOutcome: resource is stu3.OperationOutcome,
    );
  }

  factory AtFhirObject.r4(r4.Resource resource) {
    r4.Resource newResource;
    if (resource.resourceType == null) {
      newResource = r4.OperationOutcome(
        contained: [resource],
        issue: [
          r4.OperationOutcomeIssue(
              severity: r4.FhirCode('error'),
              code: r4.FhirCode('structure'),
              details: r4.CodeableConcept(
                text:
                    'No resourceType was present in the resource contained in this OperationOutcome',
              )),
        ],
      ).newId();
    } else if (resource.fhirId == null) {
      newResource = resource.newId();
    } else {
      newResource = resource;
    }

    return AtFhirObject(
      atKey: 'fhir.r4.${newResource.resourceTypeString!}.${newResource.fhirId}',
      atFhirResource: jsonEncode(newResource.toJson()),
      isOperationOutcome: resource is r4.OperationOutcome,
    );
  }

  factory AtFhirObject.r5(r5.Resource resource) {
    r5.Resource newResource;
    if (resource.resourceType == null) {
      newResource = r5.OperationOutcome(
        contained: [resource],
        issue: [
          r5.OperationOutcomeIssue(
              severity: r5.FhirCode('error'),
              code: r5.FhirCode('structure'),
              details: r5.CodeableConcept(
                text:
                    'No resourceType was present in the resource contained in this OperationOutcome',
              )),
        ],
      ).newId();
    } else if (resource.fhirId == null) {
      newResource = resource.newId();
    } else {
      newResource = resource;
    }

    return AtFhirObject(
      atKey: 'fhir.r5.${newResource.resourceTypeString!}.${newResource.fhirId}',
      atFhirResource: jsonEncode(newResource.toJson()),
      isOperationOutcome: resource is r5.OperationOutcome,
    );
  }

  dynamic toFhir() {
    final params = atKey.split('.');
    switch (params[1]) {
      case 'r5':
        return r5.Resource.fromJsonString(atFhirResource);
      case 'r4':
        return r4.Resource.fromJsonString(atFhirResource);
      case 'stu3':
        return stu3.Resource.fromJsonString(atFhirResource);
      case 'dstu2':
        return dstu2.Resource.fromJsonString(atFhirResource);
      default:
    }
  }
}
