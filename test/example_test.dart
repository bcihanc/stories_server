import 'package:dio/dio.dart';

import 'harness/app.dart';

Future main() async {
  // final harness = Harness()..install();
  const ip = "161.35.61.213";

  // test("", () async {
  //   expectResponse(await harness.agent.post("$ip/register"), 200, body: {
  //     "username": "cihan",
  //     "password": "323591"
  //   }, headers: {
  //     "Authorization": "Basic Y29tLnR1dG9yaWFsLnN0b3JpZXM6YmNj",
  //     "Content-Type": "application/json"
  //   });
  // });

  test("", () async {
    await Dio().post("$ip/register",
        data: {"username": "cihanx", "password": "323591"},
        options: Options(headers: {
          "Authorization": "Basic Y29tLnR1dG9yaWFsLnN0b3JpZXM6YmNj",
          "Content-Type": "application/json"
        }));
  });
}
