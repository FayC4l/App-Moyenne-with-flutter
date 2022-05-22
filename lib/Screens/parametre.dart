import 'package:flutter/material.dart';
import 'package:gpadz/logic/module_model.dart';
import 'package:gpadz/main.dart';

class PlusOPtion extends StatefulWidget {
  const PlusOPtion({Key? key}) : super(key: key);

  @override
  State<PlusOPtion> createState() => _PlusOPtionState();
}

class _PlusOPtionState extends State<PlusOPtion> {
  bool newvalue = false;
  @override
  void initState() {
    themeManager.addListener(themeListner);
    super.initState();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  int i = 0;
  final UrlDuaa = [
    "من الادعية قبل الامتحان اللهم يا معلّم موسى علّمني ويا مفهم سليمان فهّمني ويا مؤتي لقمان الحكمة وفصل الخطاب آتني الحكمة وفصل الخطاب اللهم اجعل ألستنا عامرة بذكرك وقلوبنا بخشيتك وأسرارنا بطاعتك إنك على كل شيء قدير حسبنا الله ونعم الوكيل عند التوجّه إلى الامتحاناللهم إني توكلت عليك وفوضت أمري إليك لا ملجأ ولا منجى إلا إليك",
    "دعاء بعد المذاكرةاللهم إني استودعتك ما قمت بقراءته وما قمت بحفظه وما تعلمته فاللهم رده إلي وقت حاجتي له إنك إلهي قادر على كل شيئ انت حسبي و وكيلياللهم أسألك النجاح وتحقيق الرغبات فيما تراه خيرا لي فأنت من تملك مفاتيح مسألتي يا الله لا أرجو الخير من غيرك فأنت رب الخير و أعوذ بك ربي من القنوط بعد معرفتي بفضلك يا من يقول للشيء كن فيكون يا من اسمه الكريم لا أدعو أحد سواك ولا أمل لي بغيرك مشيئتك يا رب اعتصم بها فالت نعم الوكيلاللهم أنت خير الحافظين وارحم الراحمين",
    "من ادعية عند دخول قاعة الامتحانربّ أدخلني مدخل صدق وأخرجني مخرج صدق واجعل لي من لدنك سلطاناً نصيراً ربّ اشرح لي صدري ويسر لي أمري واحلل عقدة من لساني يفقهوا قولي بسم الله الفتّاح اللهم لا سهل إلا ما جعلته سهلاً وأنت تجعل الحزن إذا شئت سهلاً يا أرحم الراحمين اللهم افتح عليَّ فتوح عبادك العارفين اللهم انقلني من حولي وقوتي وحفظي إلى حولك وقوتك وحفظك اللهم اجعل لي من لدنك سلطاناً نصيراً",
    "دعاء اثناء الامتحانلا إله إلا أنت سبحانك إني كنت من الظالمين، يا حي يا قيوم برحمتك استغيث ربّ إنّي مسّني الضر وأنت أرحم الراحمين ربّ اشرح لي صدري ويسّر لي أمري واحلل عقدةً من لساني يفقه قولي بسم الله الفتاح اللهم لا سهل إلا ما جعلته سهلاً وأنت تجعل الحزن إذا شئت سهلاً",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plus d'option"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CardOption(
              nom: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value: themeManager.themeMode == ThemeMode.dark,
                      onChanged: (newvalue) {
                        themeManager.toggleTheme(newvalue);
                      })
                ],
              ),
              func: () {
                newvalue = !newvalue;
                themeManager.toggleTheme(newvalue);
              }),
          CardOption(
              nom: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Douaa ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.book)
                ],
              ),
              func: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Doua pour l'Examen"),
                        content: Text(
                          UrlDuaa[i],
                          textAlign: TextAlign.end,
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Revenir'),
                            onPressed: () {
                              setState(() {
                                i--;
                                if (i < 0) {
                                  i = 3;
                                }
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Suivant'),
                            onPressed: () {
                              setState(() {
                                i++;
                                if (i > 3) {
                                  i = 0;
                                }
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Terminer'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                  },
                );
              }),
          CardOption(
            nom: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Réinitialiser ',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.delete_forever_outlined)
              ],
            ),
            func: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ATTENTION !'),
                    content: const Text(
                      "Effacer tous les données",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () async {
                          await ModulesDatabase.instance.deleteAll();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  const CardOption({
    Key? key,
    required this.nom,
    required this.func,
  }) : super(key: key);

  final Widget nom;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => func(),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(1),
                  child: nom),
            ],
          ),
        ),
      ),
    );
  }
}
