import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Permissions with _$Permissions {
  Permissions._();

  const factory Permissions({
    PermissionGroup permissionGroup,
    List<String> atSigns,
  }) = _Permissions;
}

enum PermissionGroup {
  @JsonValue('physician')
  physician,
  @JsonValue('nurse')
  nurse,
}
