import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:user_app/common/di/injector.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/extensions/snack_bar.dart';
import 'package:user_app/common/validation/validators_manager.dart';
import 'package:user_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:user_app/features/login/presentation/bloc/login_cubit.dart';

import '../../../../common/constants/image_constants.dart';
import '../../../../common/navigation/route_name.dart';
import '../../../../common/ui/modals/spacing.dart';
import '../../../../common/ui/widgets/buttons/primary_button.dart';
import '../../../../common/ui/widgets/text_form_field_widget.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValidationManager _validationManager;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _validationManager = injector<ValidationManager>();
    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(ImageConstants.logoImagePath),
                Text(
                  context.appLocale.login,
                  style: context.textTheme.titleLarge,
                ),
                gapH30,
                TextFormFieldWidget(
                  controller: _emailController,
                  labelText: context.appLocale.email,
                  textInputType: TextInputType.emailAddress,
                  validator: _validationManager.email(),
                  textInputAction: TextInputAction.next,
                ),
                gapH20,
                TextFormFieldWidget(
                  controller: _passwordController,
                  labelText: context.appLocale.password,
                  textInputType: TextInputType.emailAddress,
                  validator: _validationManager.password(),
                  textInputAction: TextInputAction.next,
                ),
                gapH20,
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is Success) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteName.homeScreen,
                          (Route<dynamic> route) => false);
                    }
                    if (state is Failed) {
                      var message = state.error;
                      context.showSnackbar(message, isError: true);
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return PrimaryButton(
                        isLoading: true,
                        width: context.mediaQuery.size.width,
                        onPressed: _onSubmit,
                        label: context.appLocale.login,
                      );
                    }
                    return PrimaryButton(
                      width: context.mediaQuery.size.width,
                      onPressed: _onSubmit,
                      label: context.appLocale.login,
                    );
                  },
                ),
                gapH20,
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.initialRoute);
                  },
                  child: const Text("Create an account"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
