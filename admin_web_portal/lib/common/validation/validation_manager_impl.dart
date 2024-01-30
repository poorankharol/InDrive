import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:admin_web_portal/common/validation/validators_manager.dart';

class ValidationManagerImpl implements ValidationManager {
  @override
  FormFieldValidator<String> email() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ],
    );
  }

  @override
  FormFieldValidator<String> password() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8),
      ],
    );
  }

  @override
  FormFieldValidator<String> phone() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(10),
        FormBuilderValidators.minLength(10),
      ],
    );
  }

  @override
  FormFieldValidator<String> username() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8),
      ],
    );
  }

  @override
  FormFieldValidator<String> carColor() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
      ],
    );
  }

  @override
  FormFieldValidator<String> carModel() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(5),
      ],
    );
  }

  @override
  FormFieldValidator<String> carNumber() {
    return FormBuilderValidators.compose(
      [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(10),
        FormBuilderValidators.minLength(7),
      ],
    );
  }
}
