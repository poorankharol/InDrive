import 'package:flutter/widgets.dart';

abstract class ValidationManager {
  FormFieldValidator<String> email();
  FormFieldValidator<String> username();
  FormFieldValidator<String> phone();
  FormFieldValidator<String> password();
}
