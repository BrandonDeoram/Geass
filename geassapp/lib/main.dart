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
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        // Input method you want change before build.
        AnimeNotifier animeNotifier =
            Provider.of<AnimeNotifier>(context, listen: false);
        DataBaseService().getAnimes(animeNotifier);
        DataBaseService().getAdventureAnime(animeNotifier);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimeNotifier animeNotifier = Provider.of<AnimeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start of a new app'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: animeNotifier.adventureList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(animeNotifier.adventureList[index].name),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
