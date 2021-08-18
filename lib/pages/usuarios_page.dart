import 'package:chat/helpers/color_palets.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 'test1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Juan', email: 'test2@test.com', online: true),
    Usuario(uid: '3', nombre: 'José', email: 'test3@test.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final usuario = authservice.usuario;

    return Scaffold(
        backgroundColor: colorPaletNegro(),
        appBar: AppBar(
          title: Center(
            child: Text(
              usuario.nombre,
              style: TextStyle(color: Colors.white),
            ),
          ),
          elevation: 1,
          backgroundColor: colorPaletGris(),
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO: Desconectarnos del Socket Server

              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.wifi, color: Colors.white,
                //child: Icon(Icons.check_circle, color: Colors.blue[400],
              ),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: colorPaletMorado(),
            ),
            waterDropColor: colorPaletMorado(),
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) => _usuarioListTitle(usuarios[i]),
        separatorBuilder: (context, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre, style: TextStyle(color: Colors.white60)),
      subtitle: Text(
        usuario.email,
        style: TextStyle(color: Colors.white60),
      ),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: colorPaletMorado(),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.greenAccent[200] : Colors.grey,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
