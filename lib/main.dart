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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePage extends StatelessWidget {
  //const HomePage(Key? key):super(key:key);
  //Criando uma variável que ira armazenar a contagem
  int count = 0;

  void decrement() {
    count--;
    print(count);
  }

  void increment() {
    count++;
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("assets/images/fiap_bg.png"),
            fit:BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Alinhado no eixo da vertical
          children: [
            Text(
              "Pode Entrar!",
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
                  onPressed: decrement,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(100, 20),
                  ),
                  child: Text(
                    "Saiu",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: increment,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
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
