import 'package:aqueduct/managed_auth.dart';
import 'package:stories_server/controller/register_controller.dart';
import 'package:stories_server/controller/stories_controller.dart';
import 'package:stories_server/controller/user_controller.dart';
import 'package:stories_server/model/user.dart';

import 'stories_server.dart';

class StoriesServerChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = Configs(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final store = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, store);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/auth/token').link(() => AuthController(authServer));

    router
        .route('/register')
        .link(() => Authorizer.basic(authServer))
        .link(() => RegisterController(context, authServer));

    router
        .route("/stories/[:id]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => StoriesController(context));

    router
        .route("/user/[:id]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserController(context));

    return router;
  }
}

class Configs extends Configuration {
  Configs(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
