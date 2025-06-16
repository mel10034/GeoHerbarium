import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolog/layers/presentation/notifiers/auth_notifiers/sign_up_second_notifier.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_in.dart';
import 'package:geolog/layers/presentation/pages/common/toast.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:provider/provider.dart';

class SignUpSecond extends StatelessWidget {
  const SignUpSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpSecondNotifier(),
      child: const SubSignUpSecond(),
    );
  }
}

class SubSignUpSecond extends StatelessWidget {
  const SubSignUpSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Center(
                child: Text(
              'Загрузить аватар',
              style: MyFontStyle.subMainTitle,
            )),
            SizedBox(
              height: 70.h,
            ),
            const SetAvatar(),
            const Spacer(),
            const LoadButton(),
            SizedBox(
              height: 20.h,
            ),
            const SkipButton(),
            SizedBox(
              height: 90.h,
            ),
          ],
        ),
      ),
    );
  }
}

class SetAvatar extends StatelessWidget {
  const SetAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpSecondNotifier>();
    return GestureDetector(
      onTap: () => notifier.setImage(),
      child: Center(
        child: notifier.bytes != null
            ? Container(
                width: 160.w,
                height: 160.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: MemoryImage(notifier.bytes as Uint8List),
                        fit: BoxFit.cover),
                    color: Colors.grey.shade900),
              )
            : Container(
                width: 160.w,
                height: 160.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade900),
              ),
      ),
    );
  }
}

class LoadButton extends StatelessWidget {
  const LoadButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpSecondNotifier>();
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {
            if (notifier.bytes == null) {
              FToast fToast = FToast();
              fToast.init(context);
              fToast.showToast(
                  gravity: ToastGravity.TOP,
                  toastDuration: const Duration(seconds: 2),
                  child: toast("Все поля должны быть заполнены", context));
            } else {
              notifier.loadAvatar(notifier.bytes, context);
            }
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Загрузить',
            style: MyFontStyle.subTitleBlack,
          ),
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignIn())),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Пропустить',
            style: MyFontStyle.subTitle,
          ),
        ),
      ),
    );
  }
}
