import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/common/constants/image_constants.dart';
import 'package:user_app/common/di/injector.dart';
import 'package:user_app/common/extensions/build_context_extensions.dart';
import 'package:user_app/common/extensions/snack_bar.dart';
import 'package:user_app/common/navigation/route_name.dart';
import 'package:user_app/common/ui/modals/spacing.dart';
import 'package:user_app/common/ui/widgets/buttons/primary_button.dart';
import 'package:user_app/common/validation/validators_manager.dart';
import 'package:user_app/features/register/presentation/bloc/register_cubit.dart';
import 'package:user_app/common/ui/widgets/text_form_field_widget.dart';

import '../bloc/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _userNameController;
  late TextEditingController _userPhoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValidationManager _validationManager;

  @override
  void initState() {
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _userPhoneController = TextEditingController();
    _validationManager = injector<ValidationManager>();
    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  _registerUser() {
    context.read<RegisterCubit>().register(
        email: _emailController.text, password: _passwordController.text);
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(ImageConstants.logoImagePath),
              Text(
                context.appLocale.createAnAccount,
                style: context.textTheme.titleLarge,
              ),
              gapH30,
              TextFormFieldWidget(
                controller: _userNameController,
                labelText: context.appLocale.username,
                textInputType: TextInputType.emailAddress,
                validator: _validationManager.username(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
              TextFormFieldWidget(
                controller: _userPhoneController,
                labelText: context.appLocale.phoneNumberLabel,
                textInputType: TextInputType.number,
                validator: _validationManager.phone(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
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
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is Success) {
                    User user = state.user;
                    context.read<RegisterCubit>().insertIntoDatabase(
                          user: user,
                          name: _userNameController.text,
                          phone: _userPhoneController.text,
                          blockStatus: false,
                        );
                  }
                  if (state is AddUserToDbSuccess) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteName.homeScreen, (Route<dynamic> route) => false);
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
                      label: context.appLocale.register,
                    );
                  }
                  return PrimaryButton(
                    width: context.mediaQuery.size.width,
                    onPressed: _onSubmit,
                    label: context.appLocale.register,
                  );
                },
              ),
              gapH20,
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                },
                child: const Text("Already have an account? Login Here"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
