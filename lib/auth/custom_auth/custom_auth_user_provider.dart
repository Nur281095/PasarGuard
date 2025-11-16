import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class PasargadrugsAuthUser {
  PasargadrugsAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<PasargadrugsAuthUser> pasargadrugsAuthUserSubject =
    BehaviorSubject.seeded(PasargadrugsAuthUser(loggedIn: false));
Stream<PasargadrugsAuthUser> pasargadrugsAuthUserStream() =>
    pasargadrugsAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
