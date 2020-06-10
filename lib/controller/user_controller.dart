import 'package:stories_server/model/user.dart';
import 'package:stories_server/stories_server.dart';

class UserController extends ResourceController {
  UserController(this.context);
  final ManagedContext context;

  @Operation.get("id")
  Future<Response> getAllStoriesByUserId(@Bind.path("id") int id) async {
    final query = Query<User>(context)
      ..where((user) => user.id).identifiedBy(request.authorization.ownerID)
      ..where((user) => user.id).equalTo(id);

    final stories = await query.join(set: (a) => a.stories).fetch();
    return Response.ok(stories);
  }
}
