import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:devti_front_final/model/pessoa.dart';
import 'package:devti_front_final/util/combo_cidade.dart';
import 'package:devti_front_final/util/componentes.dart';
import 'package:devti_front_final/util/radio_sexo.dart';
import 'package:flutter/material.dart';

class CadastroCliente extends StatefulWidget {
  final Pessoa? pessoa;
  const CadastroCliente({super.key, this.pessoa});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  @override
  Widget build(BuildContext context) {
    Pessoa? pessoa = widget.pessoa;
    int id = pessoa != null ? pessoa.id : 0;
    GlobalKey<FormState> formController = GlobalKey<FormState>();
    TextEditingController txtNome =
        TextEditingController(text: pessoa != null ? pessoa.nome : "");
    TextEditingController txtIdade = TextEditingController(
        text: pessoa != null ? pessoa.idade.toString() : "");
    TextEditingController txtSexo =
        TextEditingController(text: pessoa != null ? pessoa.sexo : "f");
    TextEditingController txtCidade = TextEditingController(
        text: pessoa != null ? pessoa.cidade.id.toString() : "");
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastrar() {
      Pessoa p = Pessoa(id, txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      AcessoApi().inserePessoa(p.toJson());
      Navigator.of(context).pushReplacementNamed("/cliente/consulta");
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Cadastro de Cliente"),
      body: Form(
        key: formController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Componentes()
                .criaInputTexto("Nome", txtNome, "Deve ser preenchido!"),
            Componentes()
                .criaInputTexto("Idade", txtIdade, "Deve ser preenchido!"),
            RadioSexo(controller: txtSexo),
            ComboCidade(controller: txtCidade),
            Componentes().criaBotao(formController, "Cadastrar", cadastrar),
          ],
        ),
      ),
    );
  }
}
