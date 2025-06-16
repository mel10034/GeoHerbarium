import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolog/layers/presentation/notifiers/auth_notifiers/sign_in_notifier.dart';
import 'package:geolog/layers/presentation/pages/auth/sign_up.dart';
import 'package:geolog/layers/presentation/pages/common/toast.dart';
import 'package:geolog/layers/presentation/style/colors.dart';
import 'package:geolog/layers/presentation/style/fontstyle.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInNotifier(),
      child: const SubSignIn(),
    );
  }
}

class SubSignIn extends StatelessWidget {
  const SubSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Гео',
                        style: MyFontStyle.hugeBrandTitle,
                      ),
                      Text(
                        'Гербарий',
                        style: MyFontStyle.hugeTitle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 135.h,
                ),
                Text(
                  'Вход',
                  style: MyFontStyle.subMainTitle,
                ),
                SizedBox(
                  height: 25.h,
                ),
                const EmailField(),
                SizedBox(
                  height: 25.h,
                ),
                const PasswordField(),
                SizedBox(
                  height: 150.h,
                ),
                const SignInButton(),
                SizedBox(
                  height: 20.h,
                ),
                const SignUpButton(),
              ],
            ),
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
    final notifier = context.watch<SignInNotifier>();
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {
            if (!notifier.isLoading) {
              if (notifier.email.isEmpty || notifier.password.isEmpty) {
                FToast fToast = FToast();
                fToast.init(context);
                fToast.showToast(
                    gravity: ToastGravity.TOP,
                    toastDuration: const Duration(seconds: 2),
                    child: toast("Все поля должны быть заполнены", context));
              } else {
                notifier.signIn(notifier.email, notifier.password, context);
              }
            }
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(MyColors.brandColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: notifier.isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  ))
              : Text(
                  'Войти',
                  style: MyFontStyle.subTitleBlack,
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
    return Center(
      child: SizedBox(
        width: 280.w,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignUp())),
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          child: Text(
            'Зарегистрироваться',
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
    final notifier = context.watch<SignInNotifier>();
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

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SignInNotifier>();
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
