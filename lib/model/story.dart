import 'package:stories_server/model/user.dart';
import 'package:stories_server/stories_server.dart';

class Story extends ManagedObject<_Story> implements _Story {
  @override
  void willUpdate() {
    updatedAt = DateTime.now().toUtc();
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
    updatedAt = DateTime.now().toUtc();
  }
}

class _Story {
  @primaryKey
  int id;

  String title;

  @Column(nullable: true)
  String contents;

  @Column(indexed: true)
  DateTime createdAt;

  @Column(indexed: true)
  DateTime updatedAt;

  @Relate(#stories, onDelete: DeleteRule.cascade, isRequired: true)
  User owner;
}
