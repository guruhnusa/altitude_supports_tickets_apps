import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/assets/fonts.gen.dart';
import 'src/core/routes/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Altitude Support Ticket',
      theme: ThemeData(
        fontFamily: FontFamily.poppins,
        scaffoldBackgroundColor: Colors.white,
      ),
      routeInformationParser: ref.watch(routersProvider).routeInformationParser,
      routeInformationProvider: ref.watch(routersProvider).routeInformationProvider,
      routerDelegate: ref.watch(routersProvider).routerDelegate,
    );
  }
}
