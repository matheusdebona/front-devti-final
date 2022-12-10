import 'package:devti_front_final/api/acesso_api.dart';
import 'package:devti_front_final/model/cidade.dart';
import 'package:devti_front_final/model/pessoa.dart';
import 'package:devti_front_final/pages/cadastro_cidade.dart';
import 'package:devti_front_final/pages/cadastro_cliente.dart';
import 'package:flutter/material.dart';

class Componentes {
  Future<bool> isCityUsed(String cidade) async {
    List<Pessoa> pessoas = await AcessoApi().listaPessoas();
    for (var pessoa in pessoas) {
      if (pessoa.cidade.nome == cidade) {
        return true;
      }
    }
    return false;
  }

  criaTexto([texto, cor, tamanho]) {
    return Text(
      texto,
      style: TextStyle(
        color: cor,
        fontSize: tamanho,
      ),
    );
  }

  criaIconeGrande(icone, tamanho, [cor]) {
    return Container(
      child: Icon(
        icone,
        size: tamanho,
        color: cor,
      ),
    );
  }

  criaAppBar(acao, texto) {
    return AppBar(
      title: criaTexto(texto, Colors.white, 32.0),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          onPressed: acao,
          icon: const Icon(Icons.home),
        )
      ],
    );
  }

  criaInputTexto(textoLabel, controlador, msgValidacao, [tipoTeclado]) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: textoLabel,
          labelStyle: const TextStyle(fontSize: 20),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controlador,
        validator: ((value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        }),
      ),
    );
  }

  criaBotao(controladorForm, texto, funcao) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                if (controladorForm.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                texto,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  criaBotaoEditCid(context, cidade) {
    return ElevatedButton(
      child: const Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CadastroCidade(
                  cidade: cidade,
                )),
          ),
        );
      },
    );
  }

  criaBotaoEditCli(context, pessoa) {
    return ElevatedButton(
      child: const Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CadastroCliente(
                  pessoa: pessoa,
                )),
          ),
        );
      },
    );
  }

  criaBotaoExcluir(context, objeto, funcao) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        child: const Icon(Icons.delete),
        onPressed: () async {
          Navigator.pop(context);
          if (await isCityUsed(objeto.nome)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: const Text("OK")),
                ],
                title: const Text("Não pode fazer isso."),
                content: const Text(
                    "Esta cidade pertence a algum usuário cadastrado."),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: (() {
                        funcao(objeto);
                        Navigator.pop(context);
                      }),
                      child: const Text("Sim")),
                  TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text("Cancelar"),
                  ),
                ],
                title: const Text("Quer mesmo deletar?"),
                content: const Text("Você não poderá voltar atrás!"),
              ),
            );
          }
        },
      ),
    );
  }

  criaBotaoConfig(contexto, objeto, funcaoDelete) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: contexto,
          builder: (BuildContext context) {
            return SizedBox(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      objeto is Cidade
                          ? criaBotaoEditCid(contexto, objeto)
                          : criaBotaoEditCli(contexto, objeto),
                      criaBotaoExcluir(contexto, objeto, funcaoDelete),
                      ElevatedButton(
                        onPressed: (() {
                          Navigator.pop(contexto);
                        }),
                        child: Icon(Icons.close),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.settings),
    );
  }

  criaItemPessoa(Pessoa p, contexto, funcaoDelete) {
    String sexo = p.sexo == "m" ? "Masculino" : "Feminino";
    return ListTile(
      title: criaTexto("${p.nome} - ${p.idade} anos - $sexo "),
      subtitle: criaTexto("${p.cidade.nome} - ${p.cidade.uf}"),
      trailing: criaBotaoConfig(contexto, p, funcaoDelete),
    );
  }

  criaItemCidade(Cidade cidade, context, funcaoDelete) {
    return ListTile(
      title: criaTexto("${cidade.nome} - ${cidade.uf}"),
      trailing: criaBotaoConfig(context, cidade, funcaoDelete),
    );
  }

  criaInputBusca(String textoLabel, TextEditingController controlador,
      formController, funcao) {
    return ListTile(
      title: textoLabel == ""
          ? criaInputTexto(
              "Buscar por Cidade", controlador, "Deve ser preenchido")
          : null,
      trailing: Container(
        height: 500,
        child: ElevatedButton(
          onPressed: () {
            funcao();
          },
          child: Text(
            "Buscar",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
