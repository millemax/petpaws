import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  //declaramos los streams para controlar el correo y la contra
  //cada vez que yo teclee va pasar por este stream controller
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //inseratar valores al stream, solo estring voy a recibir
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //escuchar/recuperar los datos del estream
  //lo que sale de este stream van a ser strings
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  //metodo dispose para cerrar cuando ya no necesite el streamcontroller
  //--?: si esto fuera nulo entonces no va ejecutar .puntoclose() que nos daria un error

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

  //streamtransformers y validaciones
  //es conveniete decir que info fluye y sale atravez del streamtranformer
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres');
    }
  });

  //validar email
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern patron =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(patron);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

//obtener el ultimo valor ingresado de email y contaraseña
  String get email => _emailController.value;
  String get contrasena => _passwordController.value;
}
