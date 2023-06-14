# fhirlite_central

## File Structure

    - assets/
        - @sign_key.atKeys
    - bin/
        - server.dart
    - hive/
        - .fhir/
            - @sign/
                - storage/
    - home
        - .fhir/
            - @sign/
                - storage/
                    - commitLog/
    - lib/
        - src.dart
        - src/
            - services/

## Formatting

### Keys for FHIR resources stored on a person's atSign

    - fhir.version.resourceType.fhirId
    - fhir.stu3.patient.12345  

    full value would be
    - @sharedWith:fhir.version.resourceType.id.nameSpace:@owner
    - @bob:fhir.r4.observation.blood-pressure.fhir:@alice 

### Server Key:Value

    - fhir.permissiongroups.namespace:@fhircentral - list of the different permissionGroups
    - fhir.permission.groupname.namespace:@fhircentral - a specific permission group, value would be a list of atsigns belonging to this group
    - @sharedWith:fhir.request.YYYYMMDDHHMMSSSS:@owner - how a request is logged. 4-digit year, 2-digit month, 2-digit day, 2-digit hour (24 hour format), 2-digit minute, 4-digit second (ss.ss - but no decimal)

## TODO Utilities (if it's a link, it's been completed)

### Permission Groups

- [Create new permission group](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_permissions.dart#L74)
- [Remove permission group](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_permissions.dart#L101)
- [Rename permission group](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_permissions.dart#L129)
- [Add atsign to permission group](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_permissions.dart#L15)
- [Remove atsign from permission group](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_permissions.dart#L44)
- decide what permission groups actually have access to

### Requests

- [Request listener](https://github.com/fhir-fli/fhirlite_central/blob/main/bin/server.dart#L11)
- Check permissions
- [Reform request](https://github.com/fhir-fli/fhirlite_central/blob/main/bin/server.dart#L19)
- [Log request](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/log_request.dart)
- [Make request](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/make_request.dart)
- [Receive result](https://github.com/fhir-fli/fhirlite_central/blob/main/bin/server.dart#L29)
- [Notify @sign](https://github.com/fhir-fli/fhirlite_central/blob/main/lib/services/at_notify.dart) of [result](https://github.com/fhir-fli/fhirlite_central/blob/main/bin/server.dart#L31)
- Create/update appropriate listening groups

### Listening group

- a listening group is a list of atsigns that should be notified about particular changes
- need to define how these groups would work
- probably should be defined by patient or by encounter
- anytime a Resource associated with that patient or encounter is created/updated, the listening group should be notified

### Patient Workflow

![Patient Workflow](https://github.com/fhir-fli/at_fhir/blob/main/png/patient_workflow.png)

### Server Workflow

![Server Workflow](https://github.com/fhir-fli/at_fhir/blob/main/png/server_workflow.png)
