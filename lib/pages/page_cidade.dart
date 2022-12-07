import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class PageCidade extends StatefulWidget {
  const PageCidade({super.key});

  @override
  State<PageCidade> createState() => _PageCidadeState();
}

class _PageCidadeState extends State<PageCidade> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cadastro() {
      Navigator.of(context).pushReplacementNamed('/cidade/cadastro');
    }

    consulta() {
      Navigator.of(context).pushReplacementNamed('/cidade/consulta');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "Dados das Cidades"),
      body: Form(
        key: formController,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Componentes().criaIconeGrande(Icons.location_city_rounded, 250),
              Componentes()
                  .criaBotao(formController, "Cadastrar Cidade", cadastro),
              Componentes()
                  .criaBotao(formController, "Consultar Cidades", consulta),
            ]),
      ),
    );
  }
}
