import 'package:beats/model/playlistmodel.dart';
import 'package:beats/splash.dart';
import 'package:beats/widgets/rateappinitwidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  await Hive.openBox<int>('favoriteDB');
  await Hive.openBox<PlayListModel>('playlist_db');
  runApp(const Beats());
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    notificationColor: Colors.grey[100],
    androidShowNotificationBadge: true,
    androidStopForegroundOnPause: true,
  );
}

// Future<void> startService() async {
//   final AudioPlayerHandler audioHandker = await AudioService.init(
//     builder: () => AudioPlayerHandlerImpl(),
//   );
// }

class Beats extends StatelessWidget {
  const Beats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RateAppInitWidget(
        builder: (rateMyApp) {
          return ScreenSplash(
            rateMyApp: rateMyApp,
          );
        },
      ),
    );
  }
}
