import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolog/layers/presentation/notifiers/auth_notifiers/sign_up_notifier.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_in.dart';
import 'package:geolog/layers/presentation/pages/common/toast.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpNotifier(),
      child: const SubSignUp(),
    );
  }
}

class SubSignUp extends StatelessWidget {
  const SubSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    'Регистрация',
                    style: MyFontStyle.subMainTitle,
                  ),
                ),
                SizedBox(
                  height: 45.h,
                ),
                const EmailField(),
                SizedBox(
                  height: 25.h,
                ),
                const NicknameField(),
                SizedBox(
                  height: 25.h,
                ),
                const PasswordField(),
                SizedBox(
                  height: 150.h,
                ),
                const SignUpButton(),
                SizedBox(
                  height: 20.h,
                ),
                const SignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpNotifier>();
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {
            if (notifier.email.isEmpty || notifier.password.isEmpty) {
              FToast fToast = FToast();
              fToast.init(context);
              fToast.showToast(
                  gravity: ToastGravity.TOP,
                  toastDuration: const Duration(seconds: 2),
                  child: toast("Все поля должны быть заполнены", context));
            } else {
              notifier.signUp(notifier.email, notifier.nickname,
                  notifier.password, context);
            }
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Зарегистрироваться',
            style: MyFontStyle.subTitleBlack,
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Войти',
            style: MyFontStyle.subTitle,
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: CupertinoTextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) => notifier.email = value,
          placeholder: "Электронная почта",
          placeholderStyle: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}

class NicknameField extends StatelessWidget {
  const NicknameField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: CupertinoTextField(
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) => notifier.nickname = value,
          placeholder: "Псевдоним",
          placeholderStyle: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignUpNotifier>();
    return Center(
      child: SizedBox(
        width: 300.w,
        height: 55.h,
        child: CupertinoTextField(
          obscureText: true,
          cursorColor: MyColors.brandColor,
          showCursor: true,
          cursorRadius: const Radius.circular(25),
          style: const TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          onChanged: (value) => notifier.password = value,
          placeholder: "Пароль",
          placeholderStyle: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w500,
              fontSize: 14.sp),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
