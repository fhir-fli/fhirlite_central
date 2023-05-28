import 'dart:convert';

import 'package:at_fhir/at_fhir.dart';
import 'package:fhir/r4.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ListeningController {
  ///Define our getter for our handler
  Handler get handler {
    final router = Router();

    /// main post route, currently only checks if there's a resource
    router.post('/', (Request request) async {
      final requestString = await request.readAsString();
      final resource = Resource.fromJson(jsonDecode(requestString));
      final afo = AtFhirObject.r4(resource);
      final updateResult = await atSignUpdateFhirResource(afo);
      return updateResult.when(
        success: () => Response.ok('Update was successful'),
        failure: (failure) => Response.ok('Updated failed. $failure'),
      );
    });

    ///You can catch all verbs and use a URL-parameter with a regular expression
    ///that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      // return Response.notFound('Page not found');
      return Response.ok('Page not found');
    });

    return router;
  }
}
