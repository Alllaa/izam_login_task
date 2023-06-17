import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izam_task/config/ConfigReader.dart';
import 'package:izam_task/lang/translation_service.dart';
import 'package:izam_task/pages/data/database_helper.dart';
import 'package:izam_task/routes/app_pages.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await ConfigReader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          enableLog: true,

          getPages: AppPages.routes,

          locale: const Locale("en"),
          fallbackLocale: TranslationService.fallbackLocale,
          supportedLocales: const [Locale('ar', ''), Locale('en', '')],
          translations: TranslationService(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

        );
      },
    );
  }
}

