import 'package:chat/helpers/color_palets.dart';
import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPaletNegro(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, //Separación en toda la pantalla de los widgets
              children: [
                Logo(
                  titulo: 'Chatting',
                ),
                _Form(),
                Labels(
                  ruta: 'register',
                  text: 'Crea una cuenta ahora!!',
                  textPregunta: '¿No tienes una cuenta ?',
                ),
                Text(
                  'Terminos y condiciones de uso\n',
                  style: TextStyle(
                      fontWeight: FontWeight.w100, color: Colors.white60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            textController: emailCtrl,
            keyworType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock,
            placeHolder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          // TODO: Crear Boton
          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      //Quita el foco y el teclado si es necesario
                      FocusScope.of(context).unfocus();

                      final loginOK = await authService.login(
                        emailCtrl.text.trim(),
                        passCtrl.text.trim(),
                      );

                      if (loginOK) {
                        //TODO: Conectar a nuestro SocketServer
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //Mostrar Alerta
                        mostrarAlerta(context, 'Login Incorrecto',
                            'Credenciales Incorrectas ');
                      }
                    })
        ],
      ),
    );
  }
}
