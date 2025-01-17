import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/utils/constant/app_colors.dart';
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox.shrink(),
        centerTitle: false,
        forceMaterialTransparency: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.primaryPurple,
          ),
          const Positioned(
            top: 40,
            child: Center(
              child: Text(
                'Altitude Support Ticket System',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: (context.deviceHeight + 60) / 2,
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              alignment: Alignment.center,
              child: ListView(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  const Gap(12),
                  CustomTextField(
                    controller: usernameController,
                    label: 'Input Username',
                  ),
                  const Gap(16),
                  const Text(
                    'Kata Sandi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                  const Gap(12),
                  CustomTextField(
                    controller: passwordController,
                    label: '***********',
                    obscureText: true,
                  ),
                  Row(
                    children: [
                      CustomCheckBox(
                        isAgree: isRemember,
                        onChanged: (value) {
                          isRemember.value = value!;
                        },
                      ),
                      const Text(
                        'Ingat Saya',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      
                    ],
                  ),
                  const Gap(12),
                  Button.filled(
                    // disabled: authState.isLoading || isButtonDisabled.value,
                    onPressed: () {},
                    label: 'Login',
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun? ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        },
                        child: const Text(
                          'Daftar Di Sini',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
