class AuthException implements Exception{

  static const Map<String, String> errors = {
    'EMAIL_EXISTS' : 'o endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED' : ' o login por senha está desativado para este projeto.',
    'TOO_MANY_ATTEMPTS_TRY_LATER' : 'bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde.',
    'EMAIL_NOT_FOUND' : 'não há registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.',
    'INVALID_LOGIN_CREDENTIALS' : ' a senha é inválida ou o usuário não tem uma senha.',
    'USER_DISABLED' : 'a conta de usuário foi desativada por um administrador.',
    'INVALID_EMAIL' : 'email inválido',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro';
  }
}