import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum sexoEnum { masculino, feminino }

class RadioSexo extends StatefulWidget {
  TextEditingController? controller;
  RadioSexo({Key? key, this.controller}) : super(key: key);

  @override
  State<RadioSexo> createState() => _RadioSexo();
}

class _RadioSexo extends State<RadioSexo> {
  sexoEnum? _escolha = sexoEnum.feminino;

  @override
  Widget build(BuildContext context) {
    _escolha =
        widget.controller?.text == "f" ? sexoEnum.feminino : sexoEnum.masculino;
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Masculino'),
            leading: Radio<sexoEnum>(
              value: sexoEnum.masculino,
              groupValue: _escolha,
              onChanged: (sexoEnum? value) {
                setState(() {
                  _escolha = value;
                  widget.controller?.text = 'm';
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Feminino'),
            leading: Radio<sexoEnum>(
              value: sexoEnum.feminino,
              groupValue: _escolha,
              onChanged: (sexoEnum? value) {
                setState(() {
                  _escolha = value;
                  widget.controller?.text = "f";
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
