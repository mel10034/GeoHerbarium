import 'package:flutter/material.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/presentation/pages/common/main_screen.dart';

class SignInNotifier extends ChangeNotifier {
  String email = '';
  String password = '';
  bool isLoading = false;

  void signIn(String email, String password, BuildContext context) async {
    try {
      setLoad();
        SupabaseSource source = SupabaseSource();
      await source.signIn(email, password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage(selectIndex: 0)),
          (route) => false);
      setLoad();
    } catch (e) {
      setLoad();
      debugPrint('Error: $e');
    }
  }

  void setLoad() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
