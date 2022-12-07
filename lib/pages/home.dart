import 'package:devti_front_final/util/componentes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    cidade() {
      Navigator.of(context).pushReplacementNamed('/cidade');
    }

    cliente() {
      Navigator.of(context).pushReplacementNamed('/cliente');
    }

    return Scaffold(
      appBar: Componentes().criaAppBar(home, "DEVTI - Acesso API"),
      body: Form(
        key: formController,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Componentes().criaBotao(formController, "Clientes", cliente),
              Componentes().criaBotao(formController, "Cidades", cidade),
            ]),
      ),
    );
  }
}
