
String emailValidator(String value, String field) {
  final regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Please enter a valid $field address';
}

requiredValidator(String value, String feild) {
  if(value.isEmpty) {
    return "Please enter an $feild";
  }

  return null;
}

minLengthValidator(String value, String field) {
  if(value.length < 8) {
    return 'Minimum length of $field is 8 characters';
  }

  return null;
}

Function(String) composeValidators(String field, List<Function> validators) {
  return (value) {
    if(validators != null && validators is List && validators.length > 0) {
      for(var validator in validators) {
        final errorMessage = validator(value, field) as String;
        if(errorMessage != null) {
          return errorMessage;
        }
      }
    }
    return null;
  };
}