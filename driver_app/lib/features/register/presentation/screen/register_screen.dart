import 'dart:io';

import 'package:driver_app/common/extensions/snack_bar.dart';
import 'package:driver_app/common/ui/theme/core/app_colors.dart';
import 'package:driver_app/common/ui/widgets/loading_dialog.dart';
import 'package:driver_app/common/utils/helpers/image_picker.dart';
import 'package:driver_app/features/register/domain/entity/driver_entity.dart';
import 'package:driver_app/features/register/domain/entity/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_app/common/constants/image_constants.dart';
import 'package:driver_app/common/di/injector.dart';
import 'package:driver_app/common/extensions/build_context_extensions.dart';
import 'package:driver_app/common/navigation/route_name.dart';
import 'package:driver_app/common/ui/modals/spacing.dart';
import 'package:driver_app/common/ui/widgets/buttons/primary_button.dart';
import 'package:driver_app/common/validation/validators_manager.dart';
import 'package:driver_app/features/register/presentation/bloc/register/register_cubit.dart';
import 'package:driver_app/common/ui/widgets/text_form_field_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/storage/storage_provider.dart';
import '../bloc/register/register_state.dart';

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
  late TextEditingController _vehicleModelController;
  late TextEditingController _vehicleColorController;
  late TextEditingController _vehicleNumberController;
  late ValidationManager _validationManager;
  File? _pickedImage;
  String? _downloadURL;

  @override
  void initState() {
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _userPhoneController = TextEditingController();
    _vehicleModelController = TextEditingController();
    _vehicleColorController = TextEditingController();
    _vehicleNumberController = TextEditingController();
    _validationManager = injector<ValidationManager>();
    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _userPhoneController.dispose();
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              gapH50,
              _buildImage(),
              gapH20,
              Text(
                context.appLocale.createAnDriverAccount,
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
                textInputType: TextInputType.visiblePassword,
                validator: _validationManager.password(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
              TextFormFieldWidget(
                controller: _vehicleModelController,
                labelText: context.appLocale.carModel,
                textInputType: TextInputType.text,
                validator: _validationManager.carModel(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
              TextFormFieldWidget(
                controller: _vehicleColorController,
                labelText: context.appLocale.carColor,
                textInputType: TextInputType.text,
                validator: _validationManager.carColor(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
              TextFormFieldWidget(
                controller: _vehicleNumberController,
                labelText: context.appLocale.carNumber,
                textInputType: TextInputType.text,
                validator: _validationManager.carNumber(),
                textInputAction: TextInputAction.next,
              ),
              gapH20,
              _buildButton(),
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

  _submitDriverInfo() {
    if (_pickedImage != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
              file: _pickedImage!, onComplete: (onProfileUpdateComplete) {})
          .then((profileImageUrl) {
        _driverInfo(profileUrl: profileImageUrl);
      });
    } else {
      _driverInfo(profileUrl: "");
    }
  }

  _driverInfo({String? profileUrl}) {
    context.read<RegisterCubit>().register(
        driverEntity: DriverEntity(
            photo: profileUrl,
            name: _userNameController.text,
            email: _emailController.text,
            phone: _userPhoneController.text,
            blockStatus: false),
        vehicleEntity: VehicleEntity(
          carModel: _vehicleModelController.text,
          carNumber: _vehicleNumberController.text,
          carColor: _vehicleColorController.text,
        ),
        password: _passwordController.text);
  }

  _buildButton() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is Success) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.homeScreen, (Route<dynamic> route) => true);
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
        if (state is Failed) {
          return PrimaryButton(
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
    );
  }

  _chooseImage() async {
    XFile? pickedImage = await ImagePickerUtils.pickImage();
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _submitDriverInfo();
    }
  }

  _buildImage() {
    return Stack(
      children: [
        _pickedImage == null
            ? const CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(ImageConstants.avatarImagePath),
              )
            : Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(_pickedImage!),
                  ),
                ),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              _chooseImage();
            },
            icon: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.edit_rounded,
                size: 20,
                color: AppColors.background,
              ),
            ),
          ),
        )
      ],
    );
  }
}
