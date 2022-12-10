import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:devti_front_final/model/pessoa.dart';
import 'package:devti_front_final/util/combo_cidade.dart';
import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class ConsultaCliente extends StatefulWidget {
  const ConsultaCliente({super.key});

  @override
  State<ConsultaCliente> createState() => _ConsultaClienteState();
}

class _ConsultaClienteState extends State<ConsultaCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  GlobalKey<FormState> formControllerSearch = GlobalKey<FormState>();
  TextEditingController buscaController = TextEditingController();
  List<Pessoa> lista = [];
  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listarTodas() async {
      List<Pessoa> pessoas = await AcessoApi().listaPessoas();
      setState(() {
        lista = pessoas;
      });
    }

    listaPessoasPorCidade() async {
      List<Pessoa> pessoas =
          await AcessoApi().listaPessoasPorCidade(buscaController.text);
      setState(() {
        lista = [];
        lista = pessoas;
      });
    }

    deletarPessoa(Pessoa pessoa) async {
      await AcessoApi().deletarPessoa(pessoa);
      setState(() {
        listarTodas();
      });
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Consulta de Cliente"),
      body: Form(
        key: formController,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Componentes().criaBotao(formController, "Listar Todos", listarTodas),
          Form(
            key: formControllerSearch,
            child: Componentes().criaInputBusca("", buscaController,
                formControllerSearch, listaPessoasPorCidade),
          ),
          Expanded(
              child: Container(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(6),
                  child: Componentes()
                      .criaItemPessoa(lista[index], context, deletarPessoa),
                );
              },
            ),
          ))
        ]),
      ),
    );
  }
}
