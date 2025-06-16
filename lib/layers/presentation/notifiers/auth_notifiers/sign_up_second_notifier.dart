
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_in.dart';
import 'package:image_picker/image_picker.dart';

  class SignUpSecondNotifier extends ChangeNotifier {
    XFile? file;
    Uint8List? bytes;

    void setImage() async{
      ImagePicker picker = ImagePicker();
       file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if(file == null) return;
     bytes =  await file!.readAsBytes();
     notifyListeners();
    }

  void loadAvatar(Uint8List? bytes,BuildContext context) async {
    if(bytes == null) return;
    try {
      SupabaseSource source = SupabaseSource();
      await source.loadAvatar(base64Encode(bytes));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignIn()), (route) => false);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }


}