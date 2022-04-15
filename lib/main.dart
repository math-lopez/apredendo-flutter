import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando transferência"),
      ),
      body: Column(children: [
        Editor(
            controller: _controllerCampoConta,
            label: "Numero da conta",
            dica: "digite a conta"),
        Editor(
            controller: _controllerCampoValor,
            label: "valor",
            dica: "digite o valor",
            icon: Icon(Icons.monetization_on)),
        ButtonConfirmarFormularioTransferencia(
          numeroContaController: _controllerCampoConta,
          valorController: _controllerCampoValor,
        )
      ]),
    );
  }
}

class ButtonConfirmarFormularioTransferencia extends StatelessWidget {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  final TextEditingController? numeroContaController;
  final TextEditingController? valorController;

  ButtonConfirmarFormularioTransferencia(
      {this.numeroContaController, this.valorController});

  _criaTransferencia() {
    int? numeroConta = int.tryParse(this.numeroContaController?.text ?? "");
    double? valor = double.tryParse(this.valorController?.text ?? "");

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: () => _criaTransferencia(),
      child: const Text('Confirmar'),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? dica;
  final Icon? icon;

  Editor({this.controller, this.label, this.dica, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(label ?? ""),
          hintText: dica,
          icon: icon,
        ),
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.00, 0001)),
          ItemTransferencia(Transferencia(9223.29, 0003))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  Icon iconMoney = Icon(Icons.monetization_on);
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: iconMoney,
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.conta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Trasnferencia { valor: $valor, numeroConta: $conta }';
  }
}
