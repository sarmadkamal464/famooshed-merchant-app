import 'package:famooshed_vendor/app/common/util/initializer.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import 'app/modules/chat_module/firebase_chat_serivice/firebase_helper.dart';
import 'app/modules/widgets/base_widget.dart';
import 'app/theme/size_config.dart';

void main() {
  Initializer.init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    await FirebaseMessages().getFCMToken();

    await initMixPanel();

    // FCM in app Terminated State
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      FirebaseMessages.notificationOperation(message: initialMessage.data);
      // _firebaseMessagingBackgroundHandler(initialMessage);
      print(initialMessage.data);
    }
    runApp(const MyApp());
  });
}

Mixpanel? mixpanel;

initMixPanel() async {
  mixpanel = await Mixpanel.init("de11101552dc09b4c2e9ae47d29a1088",
      trackAutomaticEvents: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (_, __) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: AppPages.INITIAL,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.routes,
        initialBinding: InitialBindings(),
        builder: (_, child) => BaseWidget(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
