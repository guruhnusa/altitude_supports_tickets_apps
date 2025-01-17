import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/extensions/build_context_ext.dart';
import '../../../../core/helpers/buttons/buttons.dart';
import '../../../../core/helpers/text_field/custom_text_field.dart';
import '../../../../core/routes/router_name.dart';
import '../../../../core/utils/constant/app_colors.dart';
import '../../data/datasources/local/login_credential_manager.dart';
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
      LoginCredentialManager manager = await LoginCredentialManager.init();
      final model = await manager.read();
      if (model != null) {
        usernameController.text = model.username;
        passwordController.text = model.password;
        isRemember.value = true;
      } else {
        isRemember.value = false;
      }
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

    final authState = ref.watch(authProvider);

    ref.listen(
      authProvider,
      (previous, next) async {
        LoginCredentialManager manager = await LoginCredentialManager.init();
        if (next is AsyncData && next.value != null) {
          if (isRemember.value) {
            await manager.save(
              username: usernameController.text,
              password: passwordController.text,
            );
          } else {
            await manager.delete();
          }
          if (context.mounted) {
            context.showSuccessSnackbar(message: 'Login Success');
            context.pushReplacementNamed(PathName.home);
          }
        } else if (next is AsyncError) {
          await manager.delete();
          if (context.mounted) {
            context.showErrorSnackbar(message: 'Login Failed');
          }
        }
      },
    );

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
            disabled: authState.isLoading || isButtonDisabled.value,
            onPressed: () {
              ref.read(authProvider.notifier).login(
                    username: usernameController.text,
                    password: passwordController.text,
                  );
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
