// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_in.dart';
import 'package:geolog/layers/presentation/pages/common/main_screen.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://ybtmhmcuudcbiojupcnw.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlidG1obWN1dWRjYmlvanVwY253Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3MDE2MjMsImV4cCI6MjA1NzI3NzYyM30.dXbjQuBI3F-6lS4U0SO-rar6tt1vrmbgac2SmV4koYE';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Session? session = Supabase.instance.client.auth.currentSession;
    User? user = Supabase.instance.client.auth.currentUser;
    debugPrint(user?.userMetadata?['role']);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GeoHerbarium',
        theme: ThemeData(
            colorScheme: ColorScheme.light(primary: MyColors.brandColor)),
        home: session == null ? const SignIn() : MainPage(selectIndex: 0),
      ),
    );
  }
}
