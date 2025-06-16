import 'package:flutter/material.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_up_second.dart';

class SignUpNotifier extends ChangeNotifier {
  String email = '';
  String nickname = '';
  String password = '';

  void signUp(String email,String nickname,String password,BuildContext context) async {
    try {
      SupabaseSource source = SupabaseSource();
      String userId =  await source.signUp(email, password);
      await source.registerProfile(userId, nickname);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignUpSecond()), (route) => false);
    }
    catch(e){
      debugPrint("Error: $e");
    }
  }


}