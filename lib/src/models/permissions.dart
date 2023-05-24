import 'package:freezed_annotation/freezed_annotation.dart';

part 'permissions.freezed.dart';

@freezed
class Permissions with _$Permissions {
  const Permissions._();

  const factory Permissions({
    required PermissionGroup permissionGroup,
    @Default(<String>[]) List<String> atSigns,
  }) = _Permissions;
}

enum PermissionGroup {
  @JsonValue('physician')
  physician,
  @JsonValue('nurse')
  nurse,
}
