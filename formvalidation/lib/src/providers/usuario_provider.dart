import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
class UsuarioProvider {
  // autenticación firebase  https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
  // en el link de sign up  with email/ password
/*

en el menu de authentication ->sign -in method
  proveedor habilitamos 

  en la pestaña de user podemos ver  los usuarios


En el engrane  informacion general de proyecto  -> configutarion del proyecto ahi se encuentael API key 


 */
  final String _fireBaseToken = 'AIzaSyAK_-B2qpJaq6HYxSva3wy39AAednm5Bvk';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
     final authData = {
        'email'               : email,
        'password'            : password,
        'returnSecureToken'   : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken',
      body: json.encode(authData)
    );
  
    Map<String, dynamic> decodeResp = json. decode(resp.body);
    print(decodeResp);

    if(decodeResp.containsKey('idToken')) {
        // salvar el token en el storage
        _prefs.token = decodeResp['idToken'];
        return {'ok': true, 'token': decodeResp['idToken']};
    }else{
        return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }



  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {
    final authData = {
        'email'               : email,
        'password'            : password,
        'returnSecureToken'   : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken',
      body: json.encode(authData)
    );
  
    Map<String, dynamic> decodeResp = json. decode(resp.body);
    print(decodeResp);

    if(decodeResp.containsKey('idToken')) {
        // salvar el token en el storage
          _prefs.token = decodeResp['idToken'];
        return {'ok': true, 'token': decodeResp['idToken']};
    }else{
        return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }

}