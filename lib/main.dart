import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //const HomePage(Key? key):super(key:key);
  //Criando uma variável que ira armazenar a contagem
  int count = 0;

  void decrement() {
    setState((){
      count--;
    });
  }

  void increment() {
    setState((){
      count++;
    });
  }

  bool get isEmpty => count==0;
  bool get isFull => count==50;
  bool get isAlmostFull => count>=40 && count <50;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biblioteca Fiap",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 26
            ),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("assets/images/cont_bg.jpeg"),
            fit:BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Alinhado no eixo da vertical
          children: [
            Text(
              isFull?"biblioteca lotada": (isAlmostFull? "Quase Lotado" : "Pode entrar"),
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(count.toString(), 
              style: 
              TextStyle(fontSize: 100, color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: isEmpty?null:decrement,
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty?Colors.white.withAlpha(90):Colors.white,
                    fixedSize: Size(100, 20),
                  ),
                  child: Text(
                    "Saiu",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: isFull?null:increment,
                  style: TextButton.styleFrom(
                    backgroundColor: isFull?Colors.white.withAlpha(90):Colors.white,
                    fixedSize: Size(100, 20),
                  ),
                  child: Text(
                    "Entrou",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
}
}
