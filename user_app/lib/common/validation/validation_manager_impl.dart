import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:user_app/common/validation/validators_manager.dart';

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
}
