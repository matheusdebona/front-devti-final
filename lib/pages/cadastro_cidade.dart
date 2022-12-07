import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class CadastroCidade extends StatefulWidget {
  final Cidade? cidade;
  const CadastroCidade({super.key, this.cidade});

  @override
  State<CadastroCidade> createState() => _CadastroCidadeState();
}

class _CadastroCidadeState extends State<CadastroCidade> {
  @override
  Widget build(BuildContext context) {
    Cidade? cidade = widget.cidade;
    int id = cidade != null ? cidade.id : 0;
    GlobalKey<FormState> formController = GlobalKey<FormState>();
    TextEditingController txtNome =
        TextEditingController(text: cidade != null ? cidade.nome : "");
    TextEditingController txtuf =
        TextEditingController(text: cidade != null ? cidade.uf : "");

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastrar() {
      Cidade c = Cidade(id, txtNome.text, txtuf.text);
      AcessoApi().insereCidade(c.toJson());
      Navigator.of(context).pushReplacementNamed("/cidade/consulta");
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Cadastro de Cidade"),
      body: Form(
        key: formController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Componentes().criaInputTexto(
              "Nome",
              txtNome,
              "Deve ser preenchido!",
            ),
            Componentes().criaInputTexto(
              "Estado",
              txtuf,
              "Deve ser preenchido!",
            ),
            Componentes().criaBotao(
              formController,
              "Cadastrar Cidade",
              cadastrar,
            ),
          ],
        ),
      ),
    );
  }
}
