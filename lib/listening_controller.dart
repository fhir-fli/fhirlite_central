import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:fhirlite_central/src/models/at_fhir_object.dart';
import 'package:fhirlite_central/src/services/atsign_requests.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ListeningController {
  ///Define our getter for our handler
  Handler get handler {
    final router = Router();

    /// main post route (acts the same as put), first gets the resource info
    /// for the new Resource. As long as that is valid, get the past from the
    /// URL, and as long as that exists, pass it onto the post function
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
