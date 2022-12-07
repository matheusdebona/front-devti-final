import 'dart:convert';
import 'package:devti_front_final/model/pessoa.dart';
import 'package:http/http.dart';

import '../model/cidade.dart';

class AcessoApi {
  Future<List<Pessoa>> listaPessoas() async {
    String url = "http://localhost:8080/cliente";
    Response resposta = await get(Uri.parse(url));
    String jsonFormatUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatUtf8);
    List<Pessoa> pessoas = List<Pessoa>.from(l.map((e) => Pessoa.fromJson(e)));
    return pessoas;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = "http://localhost:8080/cidade";
    Response resposta = await get(Uri.parse(url));
    String jsonFormatUtf8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatUtf8);
    List<Cidade> cidades = List<Cidade>.from(l.map((e) => Cidade.fromJson(e)));
    return cidades;
  }

  Future<void> inserePessoa(Map<String, dynamic> pessoa) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }

  Future<void> insereCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> deletarCidade(Cidade cidade) async {
    String url = 'http://localhost:8080/cidade/${cidade.id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await delete(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> deletarPessoa(Pessoa pessoa) async {
    String url = 'http://localhost:8080/cliente/${pessoa.id}';
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    await delete(Uri.parse(url), headers: headers, body: json.encode(pessoa));
  }
}
