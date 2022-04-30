import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    TextEditingController pesoController = TextEditingController();
    TextEditingController alturaController = TextEditingController();
    TextEditingController nomeController = TextEditingController();

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _infoText = "Informe seus dados!";
    List<String> _historico = [];


    void _limpaCampos() {
      pesoController.text = "";
      alturaController.text = "";
      nomeController.text = "";
      setState(() {
        _infoText = "Informe seus dados!";
        _formKey = GlobalKey<FormState>();
      });
    }

    void _calcularIMC() {
      setState(() {
        double peso = double.parse(pesoController.text);
        double altura = double.parse(alturaController.text) / 100;
        String nome = nomeController.text;
        double imc = peso / (altura * altura);
        if (imc < 18.6) {
          _infoText = "Abaixo do Peso IMC = ${imc.toStringAsPrecision(4)}";
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText = "Levemente Acima do Peso IMC = ${imc.toStringAsPrecision(4)}";
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = "Obesidade Grau I IMC = ${imc.toStringAsPrecision(4)}";
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = "Obesidade Grau II IMC = ${imc.toStringAsPrecision(4)}";
        } else if (imc >= 40) {
          _infoText = "Obesidade Grau III IMC = ${imc.toStringAsPrecision(4)}";
        }
        _historico.add('$nome: ${peso}Kg e ${altura}m = $_infoText');
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Cálculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[200],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _limpaCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.lightBlue[200],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(
                      color: Colors.lightBlue[100],
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue[100],
                    fontSize: 25.0,
                  ),
                  controller: nomeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu Nome!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.lightBlue[100],
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue[100],
                    fontSize: 25.0,
                  ),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira seu Peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.lightBlue[100],
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue[100],
                    fontSize: 25.0,
                  ),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Texto vazio!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calcularIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      color: Colors.lightBlue[200],
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 25.0,
                  ),
                ),
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _historico.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return new Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  _historico[index],
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20.0,
                                  ),
                                ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )   
              ],
            ),
          ),
        ),
      );
    }
}
