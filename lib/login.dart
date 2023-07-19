import 'package:catalogo_app/home.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  bool loginAccepted = true;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Center(
                child: Text('Entrar',
                    style: TextStyle(fontSize: 36, color: Colors.blue[400]))),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12,
                  left: 40,
                  right: 40),
              child: Column(
                children: [
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                        //errorText: funcao ? 'usuario inexistente' : null,
                        labelText: 'Usuário',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        errorText: loginAccepted
                            ? null
                            : 'Usuário ou senha incorretos',
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (await DatabaseHelper().verifyUser(
                              userController.text, passwordController.text)) {
                            print('pode entrar');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        Home(user: userController.text))));
                          } else {
                            print('xiiiii');
                            setState(() {
                              loginAccepted = false;
                            });
                          }
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () async {
                        //DatabaseHelper().insereDb();
                        //DatabaseHelper().listVideos();
                        DatabaseHelper().filterVideo(0,genre:'Animação');
                        //DatabaseHelper().filterVideo(0);

                        //DatabaseHelper().filterVideo(0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Register(user: userController.text)));
                      },
                      child: const Text('Não tem uma conta? Cadastre-se',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
