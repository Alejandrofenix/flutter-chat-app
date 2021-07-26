import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
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
                  titulo: 'Registro',
                ),
                _Form(),
                Labels(
                  ruta: 'login',
                  text: 'Inicia Sesión',
                  textPregunta: '¿Ya tienes  cuenta ?',
                ),
                Text(
                  'Terminos y condiciones de uso\n',
                  style: TextStyle(
                      fontWeight: FontWeight.w100, color: Colors.black87),
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Nombre',
            textController: nameCtrl,
            keyworType: TextInputType.text,
          ),
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
              text: 'Registrarse',
              onPressed: () {
                print(emailCtrl.text);
                print(passCtrl.text);
              })
        ],
      ),
    );
  }
}
