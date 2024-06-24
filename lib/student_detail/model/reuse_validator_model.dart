String? reuseValidatorModel(String? value){
  if(value == null|| value.isEmpty){
    return 'this field is required';
  }
  return null;
}
