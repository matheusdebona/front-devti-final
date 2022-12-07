import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:flutter/material.dart';

class ComboCidade extends StatefulWidget {
  TextEditingController? controller;

  ComboCidade({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCidade> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<ComboCidade> {
  int? cidadeSel;
  @override
  Widget build(BuildContext context) {
    String? cidTxt = widget.controller?.text;
    cidadeSel = int.tryParse(cidTxt!);
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AcessoApi().listaCidades()),
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<Cidade>? cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton(
              isExpanded: true,
              value: cidadeSel,
              icon: const Icon(Icons.arrow_drop_down),
              hint: const Text("Selecione uma cidade..."),
              elevation: 16,
              onChanged: (int? value) {
                setState(() {
                  cidadeSel = value;
                  widget.controller?.text = "$value";
                });
              },
              items: cidades?.map<DropdownMenuItem<int>>((Cidade cid) {
                return DropdownMenuItem<int>(
                  value: cid.id,
                  child: Text(cid.nome),
                );
              }).toList(),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(
                "Carregando cidades",
              )
            ],
          );
        }
      }),
    );
  }
}
