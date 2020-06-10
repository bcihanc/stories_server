import 'package:aqueduct/managed_auth.dart';
import 'package:stories_server/model/story.dart';
import "package:stories_server/stories_server.dart";

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {
  ManagedSet<Story> stories;
}
