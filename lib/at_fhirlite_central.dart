import 'dart:developer';

import 'package:at_client/at_client.dart';
import 'package:fhirlite_central/src.dart';

import 'listen.dart';

Future atFhirliteCentral() async {
  bool onboarded = false;
  while (!onboarded) {
    try {
      onboarded = await onBoarding();
    } catch (e, st) {
      log('onBoarding failed: $e\n$st');
    }
  }
  listen(AtClientManager.getInstance());
}
