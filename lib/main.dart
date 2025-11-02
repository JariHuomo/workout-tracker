import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttracker/src/routing/app_router.dart';
import 'package:workouttracker/src/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final enableDevicePreview = _shouldEnableDevicePreview();
  final app = ProviderScope(
    child: MyApp(devicePreviewEnabled: enableDevicePreview),
  );

  if (enableDevicePreview) {
    runApp(DevicePreview(builder: (context) => app));
    return;
  }

  runApp(app);
}

bool _shouldEnableDevicePreview() {
  if (kReleaseMode || kIsWeb) {
    return false;
  }

  return defaultTargetPlatform == TargetPlatform.windows;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, this.devicePreviewEnabled = false});

  final bool devicePreviewEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Workout Tracker',
      debugShowCheckedModeBanner: false,
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: theme.mode,
      builder: devicePreviewEnabled ? DevicePreview.appBuilder : null,
      locale: devicePreviewEnabled ? DevicePreview.locale(context) : null,
      useInheritedMediaQuery: devicePreviewEnabled,
      routerConfig: router,
    );
  }
}
