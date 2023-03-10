// // ignore_for_file: require_trailing_commas
// // Copyright 2019 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';


// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(MaterialApp(
// //       title: 'Remote Config Example',
// //       home: FutureBuilder<FirebaseRemoteConfig>(
// //         future: setupRemoteConfig(),
// //         builder: (BuildContext context,
// //             AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
// //           return snapshot.hasData
// //               ? MyRemoteWidget(remoteConfig: snapshot.requireData)
// //               : Container();
// //         },
// //       )));
// // }

// class MyRemoteWidget extends AnimatedWidget {
//   MyRemoteWidget({
//     required this.remoteConfig,
//   }) : super(listenable: remoteConfig);

//   final FirebaseRemoteConfig remoteConfig;

//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(' ${remoteConfig.getString('countrycode')}'),
//             ],
//         ),
//       );
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             // Using zero duration to force fetching from remote server.
//             await remoteConfig.setConfigSettings(RemoteConfigSettings(
//               fetchTimeout: const Duration(seconds: 10),
//               minimumFetchInterval: Duration.zero,
//             ));
//             await remoteConfig.fetchAndActivate();
//           } on PlatformException catch (exception) {
//             // Fetch exception.
//             print(exception);
//           } catch (exception) {
//             print(
//                 'Unable to fetch remote config. Cached or default values will be '
//                 'used');
//             print(exception);
//           }
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }

// Future<FirebaseRemoteConfig> setupRemoteConfig() async {
 
//   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.setConfigSettings(RemoteConfigSettings(
//     fetchTimeout: const Duration(seconds: 10),
//     minimumFetchInterval: const Duration(hours: 1),
//   ));
//   await remoteConfig.setDefaults(<String, dynamic>{
//     'countrycode': 'in',
  
//   });
//   RemoteConfigValue(null, ValueSource.valueStatic);
//   return remoteConfig;
// }