import 'package:stories_server/model/story.dart';
import 'package:stories_server/stories_server.dart';

class StoriesController extends ResourceController {
  StoriesController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllStories() async {
    final query = Query<Story>(context);
    final stories = await query.fetch();
    return Response.ok(stories);
  }

  @Operation.post()
  Future<Response> createStory(@Bind.body(ignore: ["id"]) Story story) async {
    final query = Query<Story>(context)..values = story;
    query.values.owner.id = request.authorization.ownerID;

    final insertedStory = await query.insert();

    return Response.ok(insertedStory);
  }
}
