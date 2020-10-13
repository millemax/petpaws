import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:petpaws/services/auth_fb.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
/* //--------------BLOC PARA FACEBOOK LOGIN
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;
  loginfacebook() async {
    print("Iniciando sesion con facebook");

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.Success:
        print("funcionó");
        break;
      case FacebookLoginStatus.Cancel:
        print("El usuario cancelo el login");
        break;
      case FacebookLoginStatus.Error:
        print("Aqui hubo un error");
        break;
    }
  } */
  //----------bloc para manejar el login para usuario existente y nuevo usuario-------------

  //declaramos los streams para controlar el correo y la contra
  //cada vez que yo teclee va pasar por este stream controller
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _celularController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();

  //inseratar valores al stream, solo estring voy a recibir
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeNombres => _nombreController.sink.add;
  Function(String) get changeCelular => _celularController.sink.add;
  Function(String) get changeConfirmPassword =>
      _passwordConfirmController.sink.add;

  //escuchar/recuperar los datos del estream
  //lo que sale de este stream van a ser strings e int
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  Stream<String> get nombreStream =>
      _nombreController.stream.transform(validarNombre);
  Stream<String> get celularStream =>
      _celularController.stream.transform(validarCelular);

  Stream<String> get passwordConfirmedStream =>
      _passwordConfirmController.stream
          .transform(validarPassword)
          .doOnData((confirmPassword) {
        if (0 != _passwordController.value.compareTo(confirmPassword)) {
          _passwordConfirmController.addError("La contraseña no coincide");
        }
      });

  Stream<bool> get registerValidStream => CombineLatestStream.combine5(
      nombreStream,
      emailStream,
      passwordStream,
      passwordConfirmedStream,
      celularStream,
      (a, b, c, d, e) => true);

  //metodo dispose para cerrar cuando ya no necesite el streamcontroller
  //--?: si esto fuera nulo entonces no va ejecutar .puntoclose() que nos daria un error

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nombreController?.close();
    _celularController?.close();
    _passwordConfirmController?.close();
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

//validar nombre

  final validarNombre = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    Pattern patronNombre =
        r'^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.-]+$';
    RegExp regExpName = new RegExp(patronNombre);
    if (regExpName.hasMatch(nombre)) {
      sink.add(nombre);
    } else {
      sink.addError('Nombre no es correcto');
    }
  });

  // validar celular

  final validarCelular = StreamTransformer<String, String>.fromHandlers(
      handleData: (celular, sink) {
    Pattern patronCelular = r"(9)[0-9]{8}";
    RegExp regExpCelular = new RegExp(patronCelular);
    if (regExpCelular.hasMatch(celular.toString())) {
      sink.add(celular);
    } else {
      sink.addError("Celular no es correcto");
    }
  });

  //validar contraseñas

//obtener el ultimo valor ingresado de email y contaraseña
  String get email => _emailController.value;
  String get contrasena => _passwordController.value;
  String get nombre => _nombreController.value;
  String get celular => _celularController.value;
}
