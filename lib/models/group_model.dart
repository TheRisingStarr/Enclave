import 'package:enclave/models/entry_model.dart';

class GroupModel {
  final String uuid;
  final String name;
  final List<EntryModel> entries;
  final List<GroupModel> groups;

  const GroupModel({
    required this.uuid,
    required this.name,
    this.entries = const [],
    this.groups = const [],
  });
}
