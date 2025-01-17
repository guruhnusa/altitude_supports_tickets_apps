import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/extensions/string_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/routes/router_name.dart';
import '../../../../core/utils/constant/app_colors.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    Future<void> validation() async {
      if (usernameController.text.isEmpty) {
        context.showErrorSnackbar(message: 'Username cannot be empty');
        return;
      }
      if (emailController.text.isEmpty) {
        context.showErrorSnackbar(message: 'Email cannot be empty');
        return;
      }
      if (!emailController.text.isEmail) {
        context.showErrorSnackbar(message: 'Email is not valid');
        return;
      }
      if (passwordController.text.isEmpty) {
        context.showErrorSnackbar(message: 'Password cannot be empty');
        return;
      }
      if (confirmPasswordController.text.isEmpty) {
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        context.showErrorSnackbar(message: 'Password and Confirm Password must be the same');
        return;
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.goNamed(PathName.login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.goNamed(PathName.login);
            },
          ),
          backgroundColor: Colors.white,
          title: const Text('Register Account',
              style: TextStyle(
                color: AppColors.neutral900,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
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
              'Email',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.neutral900,
              ),
            ),
            const Gap(12),
            CustomTextField(
              controller: emailController,
              label: 'Input your email',
              keyboardType: TextInputType.emailAddress,
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
            const Gap(12),
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.neutral900,
              ),
            ),
            const Gap(12),
            CustomTextField(
              controller: confirmPasswordController,
              label: '***********',
              obscureText: true,
            ),
            const Gap(16),
            Button.filled(
              // disabled: authState.isLoading || isButtonDisabled.value,
              onPressed: () {
                validation();
              },
              label: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
