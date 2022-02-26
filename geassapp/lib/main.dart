import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geassapp/providers/anime_notifier.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimeNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      AnimeNotifier animeNotifier =
          Provider.of<AnimeNotifier>(context, listen: false);
      DataBaseService().getTypeAnime(animeNotifier, "Drama");
      DataBaseService().getTypeAnime(animeNotifier, "Action");
      print("INITS");
    });

    super.initState();
  }
  //Plant to watch
  //-> 10075
//Animes
//->10075

//collcetion.path(planttowatch).getDocs() -> Getting animeID's then using streambuidler->pathtoanime.match(animeID's) and display that
  @override
  Widget build(BuildContext context) {
    AnimeNotifier animeNotifier =
        Provider.of<AnimeNotifier>(context, listen: true);
    print('BUILDING NOW');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start of a new app'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: ListView.builder(
              itemCount: animeNotifier.dramaList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(animeNotifier.dramaList[index].name),
                );
              },
            ),
          ),
          Container(
            height: 100,
            width: 100,
            child: ListView.builder(
              itemCount: animeNotifier.actionList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(animeNotifier.actionList[index].name),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
