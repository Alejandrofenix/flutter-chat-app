import 'dart:async';
import 'dart:convert';

import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  //Getters del token de forma estatica
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');

    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => this._autenticando;
  // Set de notificación cuando se autentifican
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final data = {'email': email, 'password': password};

    final _uri = Uri.parse('${Environment.apiURL}/login');
    final resp = await http.post(_uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};
    final _uri = Uri.parse('${Environment.apiURL}/login/new');
    final resp = await http.post(_uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    if (token != null) {
      final _uri = Uri.parse('${Environment.apiURL}/login/renew');
      final resp = await http.get(_uri,
          headers: {'Content-Type': 'application/json', 'x-token': token});
      this.autenticando = false;

      if (resp.statusCode == 200) {
        print(resp.statusCode);
        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;

        await this._guardarToken(loginResponse.token);

        return true;
      }
    }
    //this._logout();
    return false;
  }

  // Nos permite guardar el token mediante secure Storage
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  // Nos permite eliminar el token mediante secure Storage
  Future _logout() async {
    return await _storage.delete(key: 'token');
  }
}
