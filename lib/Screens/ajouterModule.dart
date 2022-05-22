import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gpadz/logic/module_model.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PageAjouteModule extends StatefulWidget {
  final Module? module;
  const PageAjouteModule({Key? key, this.module}) : super(key: key);

  @override
  State<PageAjouteModule> createState() => _PageAjouteModuleState();
}

class _PageAjouteModuleState extends State<PageAjouteModule> {
  bool _checked = false;
  double n_TD = 0, n_TP = 0;
  double n_Exam = 0, n_Moyenne = 0;

  bool isPressed2 = false;
  bool isPressedd2 = false;

  int coif = 1;
  late int Thevalue;
  late String nomModule;
  late double Moyenne;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nomModule = widget.module?.NomModule ?? '';
    Moyenne = widget.module?.Moyenne ?? 0;
    Thevalue = widget.module?.coif ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff000a1f),
          shadowColor: const Color(0xff000a1f),
          title: const Text("Ajouter Module "),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    initialValue: nomModule,
                    decoration: const InputDecoration(
                        hintText: 'Module',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onChanged: (value) async {
                      nomModule = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Coefficient :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      DropdownButton<int>(
                        items: <int>[1, 2, 3, 4, 5, 6, 7]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text("$value"),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            Thevalue = newValue!;
                          });
                          coif = Thevalue;
                        },
                        value: Thevalue,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "TD :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                            enabled: isPressedd2,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d{0,2}'))
                            ], // Only numbers can be entered

                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Note '),
                            onChanged: (value) {
                              n_TD = ParseHelper.toDouble(value);
                            }),
                      ),
                      FlutterSwitch(
                        width: 70.0,
                        height: 30.0,
                        value: isPressedd2,
                        borderRadius: 30.0,
                        padding: 8.0,
                        activeColor: Colors.green,
                        onToggle: (val) {
                          setState(() {
                            isPressedd2 = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "TP :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}'))
                          ], // Only numbers can be entered

                          keyboardType: TextInputType.number,
                          enabled: isPressed2,
                          decoration: const InputDecoration(hintText: 'Note'),
                          onChanged: (String value) {
                            n_TP = ParseHelper.toDouble(value);
                          },
                        ),
                      ),
                      FlutterSwitch(
                        width: 70.0,
                        height: 30.0,
                        value: isPressed2,
                        borderRadius: 30.0,
                        padding: 8.0,
                        activeColor: Colors.green,
                        onToggle: (val) {
                          setState(() {
                            isPressed2 = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ], // Only numbers can be entered

                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "EMD",
                    ),
                    onChanged: (value) {
                      n_Exam = ParseHelper.toDouble(value);
                    },
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      maximumSize:
                          MaterialStateProperty.all(const Size(200, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff000a1f))),
                  onPressed: () async {
                    if (nomModule.isEmpty ||
                        n_TD > 20.00 ||
                        n_TP > 20.00 ||
                        n_TD < 0 ||
                        n_TP < 0 ||
                        n_Exam < 0 ||
                        n_Exam > 20) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('ATTENTION !'),
                            content: const Text(
                              "Erreur de saisser",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 25),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      print('yooooooooooooo');
                    } else {
                      if (isPressedd2 && isPressed2) {
                        n_Moyenne = (n_TP + n_TD + (n_Exam * 2)) / 4;
                      } else {
                        if (isPressed2) {
                          n_Moyenne = ((n_Exam * 2) + n_TP) / 3;
                        } else {
                          if (isPressedd2) {
                            n_Moyenne = ((n_Exam * 2) + n_TD) / 3;
                          } else {
                            n_Moyenne = n_Exam;
                          }
                        }
                      }
                      addOrUpdateNote();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Ajouter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Icon(
                        Icons.add,
                        size: 25,
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  void addOrUpdateNote() async {
    final isUpdating = widget.module != null;

    if (isUpdating) {
      await updateNote();
    } else {
      addModule();
    }

    Navigator.of(context).pop();
  }

  Future updateNote() async {
    final note = widget.module!.copy(
      NomModule: nomModule,
      coif: coif,
      Moyenne: n_Moyenne,
    );

    await ModulesDatabase.instance.Update(note);
  }

  void addModule() async {
    final module = Module(
        NomModule: nomModule,
        coif: coif,
        Moyenne: n_Moyenne,
        createdTime: DateTime.now());
    await ModulesDatabase.instance.create(module);
  }
}

class ParseHelper {
  static double toDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
}
