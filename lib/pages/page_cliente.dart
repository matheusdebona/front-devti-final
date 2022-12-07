import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class PageCliente extends StatefulWidget {
  const PageCliente({super.key});

  @override
  State<PageCliente> createState() => _PageClienteState();
}

class _PageClienteState extends State<PageCliente> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastro() {
      Navigator.of(context).pushReplacementNamed('/cliente/cadastro');
    }

    consulta() {
      Navigator.of(context).pushReplacementNamed('/cliente/consulta');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Dados dos Clientes"),
      body: Form(
        key: formController,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Componentes().criaIconeGrande(Icons.person, 250),
              Componentes()
                  .criaBotao(formController, "Cadastrar Cliente", cadastro),
              Componentes()
                  .criaBotao(formController, "Consultar Clientes", consulta),
            ]),
      ),
    );
  }
}
