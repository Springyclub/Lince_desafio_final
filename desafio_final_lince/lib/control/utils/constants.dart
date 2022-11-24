/// Key number vacancies
const String keyNumberVacancies = 'numero_vagas';
/// Title home page
const String titleHomePage = 'Estacionamento digital';
/// Content alert dialog
const String contentAlertDiolog = 'Você deseja retirar o numero de vagas?';
/// Title alert dialog
const String titleAlertDialog = 'Sair';
/// Text confirm alert dialog
const textConfirmeButtonAlertDialog = 'Confirmar';
/// Text cancel alert dialog
const textCancelButtonAlertDialog = 'Cancelar';
/// Title form car
const titleFormCar = 'Cadastrar carro';

/// Value validator
bool valueValidator(String? value) {
  if (value != null && value.isEmpty) {
    return true;
  }
  return false;
}
/// Number validator
bool numberValidator(String? value) {
  if (value != null && value.isEmpty || int.parse(value!)<=0) {
      return false;
  }
  return true;
}