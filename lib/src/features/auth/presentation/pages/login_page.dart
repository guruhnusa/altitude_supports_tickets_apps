import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/routes/router_name.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../domain/usecases/param/login_param.dart';
import '../controllers/auth_provider.dart';
import '../widgets/custom_checkbox.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isRemember = useState(false);
    final isButtonDisabled = useState<bool>(true);

    void updateButtonState() {
      isButtonDisabled.value = usernameController.text.isEmpty || passwordController.text.isEmpty;
    }

    Future<void> initializeLoginManager() async {
      // final loginManager = await ref.read(loginManagerProvider.future);
      // final model = await loginManager.getLogin();
      // if (model != null) {
      //   phoneController.text = model.phone;
      //   passwordController.text = model.password;
      //   isRemember.value = true;
      // } else {
      //   isRemember.value = false;
      // }
    }

    useEffect(() {
      initializeLoginManager();
      usernameController.addListener(updateButtonState);
      passwordController.addListener(updateButtonState);
      return () {
        usernameController.removeListener(updateButtonState);
        passwordController.removeListener(updateButtonState);
      };
    }, [usernameController, passwordController]);

    // ref.listen(
    //   authProvider,
    //   (previous, next) async {
    //     final loginManager = await ref.read(loginManagerProvider.future);
    //     if (next is AsyncData && next.value != null) {
    //       if (isRemember.value) {
    //         final model = LoginCredentialModel(
    //           phone: phoneController.text,
    //           password: passwordController.text,
    //         );
    //         await loginManager.saveLogin(model: model);
    //       } else {
    //         await loginManager.removeLogin();
    //       }
    //       if (context.mounted) {
    //         context.showSuccessSnackbar('Login Berhasil');
    //         ref.read(routerProvider).pushReplacementNamed(RouteName.main);
    //       }
    //     } else if (next is AsyncError) {
    //       await loginManager.removeLogin();
    //       if (context.mounted) {
    //         context.showErrorSnackbar('Gagal Login');
    //       }
    //     }
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 100,
            child: Image.asset(Assets.logo.logoAltitude.path),
          ),
          const Gap(32),
          const Text(
            'Altitude Supports \nTicket System',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(20),
          const Text(
            'Username',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(12),
          CustomTextField(
            controller: usernameController,
            label: 'Input your username',
          ),
          const Gap(16),
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral900,
            ),
          ),
          const Gap(12),
          CustomTextField(
            controller: passwordController,
            label: '***********',
            obscureText: true,
          ),
          const Gap(4),
          Row(
            children: [
              CustomCheckBox(
                isAgree: isRemember,
                onChanged: (value) {
                  isRemember.value = value!;
                },
              ),
              const Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral900,
                ),
              ),
            ],
          ),
          const Gap(16),
          Button.filled(
            // disabled: authState.isLoading || isButtonDisabled.value,
            onPressed: () {
              ref.read(authProvider.notifier).login(
                    param: LoginParam(
                      username: usernameController.text,
                      password: passwordController.text,
                    ),
                  );
              context.pushReplacementNamed(PathName.home);
            },
            label: 'Login',
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Dont't have an account? ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral900,
                ),
              ),
              InkWell(
                onTap: () {
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  context.goNamed(PathName.register);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.indigo,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
