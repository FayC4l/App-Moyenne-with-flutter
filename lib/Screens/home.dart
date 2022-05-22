import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gpadz/Screens/Resultat.dart';

import 'package:gpadz/Screens/ajouterModule.dart';
import 'package:gpadz/Screens/parametre.dart';
import 'package:gpadz/custemText.dart';
import 'package:gpadz/logic/module_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Module> modules;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshModules();
  }

  @override
  void dispose() {
    ModulesDatabase.instance;
    super.dispose();
  }

  Future refreshModules() async {
    setState(() {
      isLoading = true;
    });
    modules = await ModulesDatabase.instance.readAllModule();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : modules.isEmpty
                  ? MyCustomWidget()
                  : _cardModule(),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.settings),
                label: "Plus",
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlusOPtion()),
                  );
                  refreshModules();
                }),
            SpeedDialChild(
              child: const Icon(Icons.add_box),
              label: "Ajouter un Module",
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageAjouteModule(),
                  ),
                );
                refreshModules();
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.calculate),
              label: "Calculer La moyenne",
              onTap: () {
                int sCoif = 0;
                double sMoyenne = 0;
                for (var i = 0; i < modules.length; i++) {
                  sCoif = sCoif + modules[i].coif;
                  sMoyenne = sMoyenne + (modules[i].Moyenne * modules[i].coif);
                }
                if (!modules.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultatPage(
                              Moyenne: sMoyenne / sCoif,
                            )),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('ATTENTION !'),
                          content: const Text(
                              "Veuiller saisir vos modules "),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Terminer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ));
  }

  ListView _cardModule() {
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${modules[index].NomModule}  ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        " Coef  :${modules[index].coif}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await ModulesDatabase.instance
                              .delete(modules[index].id as int);
                          refreshModules();
                        },
                        child: const Icon(Icons.delete),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      " Moyenne du module  :${modules[index].Moyenne.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (isLoading) return;

                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PageAjouteModule(
                            module: modules[index],
                          ),
                        ));

                        refreshModules();
                      },
                      child: const Icon(Icons.update),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
