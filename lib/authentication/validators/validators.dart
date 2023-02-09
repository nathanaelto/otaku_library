import 'package:form_field_validator/form_field_validator.dart';

final pseudoValidator = RequiredValidator(errorText: 'Name is required');

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'Email is not valid')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(6, errorText: 'Password length must be minimum 6'),
]);