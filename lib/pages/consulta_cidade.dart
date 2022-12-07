import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class ConsultaCidade extends StatefulWidget {
  const ConsultaCidade({super.key});

  @override
  State<ConsultaCidade> createState() => _ConsultaCidadeState();
}

class _ConsultaCidadeState extends State<ConsultaCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cidade> lista = [];
  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listarTodas() async {
      List<Cidade> cidades = await AcessoApi().listaCidades();
      setState(() {
        lista = cidades;
      });
    }

    deletarCidade(Cidade cidade) async {
      await AcessoApi().deletarCidade(cidade);
      setState(() {
        listarTodas();
      });
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Consulta de Cidades"),
      body: Form(
        key: formController,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Componentes()
              .criaBotao(formController, "Listar Cidades", listarTodas),
          Expanded(
              child: Container(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(6),
                  child: Componentes()
                      .criaItemCidade(lista[index], context, deletarCidade),
                );
              },
            ),
          ))
        ]),
      ),
    );
  }
}
