import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denikprogramatora/okna/app.dart';
import 'package:denikprogramatora/utils/loading_widget.dart';
import 'package:denikprogramatora/utils/my_container.dart';
import 'package:denikprogramatora/utils/vzhled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = true;
  bool isSignInWidget = true;
  bool showEmailPage = true;
  String oldDocId = "";

  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();

  String jazyk = "C#";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const HlavniOkno()),
        );
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const LoadingWidget()
          : Stack(
              children: [
                Center(
                  child: isSignInWidget ? signInWidget() : registerWidget(),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: TextButton(
                    onPressed: () => showAboutDialog(
                        context: context,
                        applicationName: "Kodelog",
                        applicationVersion: "2.0.1",
                        applicationLegalese:
                            "????? 2023 Maty???? Caras a Richard Pavlik??n,\n vyd??no pod licenc?? AGPLv3",
                        children: [
                          TextButton(
                            child: const Text("Zdrojov?? k??d"),
                            onPressed: () => launchUrlString(
                                "https://github.com/Royal-Buccaneers/kodelog"),
                          )
                        ]),
                    child: const Text(
                      "Licence",
                      style: Vzhled.textBtn,
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget signInWidget() {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return MyContainer(
      height: 70.h,
      width: (Device.screenType == ScreenType.mobile) ? 80.w : 40.w,
      child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kodelog",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: (Device.screenType == ScreenType.mobile) ? 60.w : 30.w,
              child: TextFormField(
                decoration: Vzhled.inputDecoration("E-mail nebo Username"),
                cursorColor: Vzhled.textColor,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailCon,
                onFieldSubmitted: (_) {
                  if (form.currentState!.validate()) {
                    signIn();
                  }
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Toto pole je povinn??!";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: (Device.screenType == ScreenType.mobile) ? 60.w : 30.w,
              child: TextFormField(
                decoration: Vzhled.inputDecoration("Heslo"),
                cursorColor: Vzhled.textColor,
                autocorrect: false,
                obscureText: true,
                controller: passwordCon,
                onFieldSubmitted: (_) {
                  if (form.currentState!.validate()) {
                    signIn();
                  }
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Toto pole je povinn??!";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: Vzhled.orangeCudlik,
              onPressed: () {
                if (form.currentState!.validate()) {
                  signIn();
                }
              },
              child: const Text("P??ihl??sit se"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("nebo"),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignInWidget = false;
                  showEmailPage = true;
                });
              },
              child: const Text(
                "P??ihla??uji se poprv??",
                style: Vzhled.textBtn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerWidget() {
    GlobalKey<FormState> form = GlobalKey<FormState>();

    return MyContainer(
      height: 70.h,
      width: (Device.screenType == ScreenType.mobile) ? 80.w : 40.w,
      child: Form(
        key: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kodelog",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            showEmailPage
                ? SizedBox(
                    width:
                        (Device.screenType == ScreenType.mobile) ? 60.w : 30.w,
                    child: TextFormField(
                      decoration: Vzhled.inputDecoration("V???? e-mail"),
                      cursorColor: Vzhled.textColor,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: emailCon,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Toto pole je povinn??!";
                        }
                        return null;
                      },
                    ),
                  )
                : SizedBox(
                    width:
                        (Device.screenType == ScreenType.mobile) ? 60.w : 30.w,
                    child: TextFormField(
                      decoration: Vzhled.inputDecoration("V???? nov?? heslo"),
                      cursorColor: Vzhled.textColor,
                      autocorrect: false,
                      obscureText: true,
                      controller: passwordCon,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Toto pole je povinn??!";
                        }
                        return null;
                      },
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            showEmailPage
                ? OutlinedButton(
                    style: Vzhled.orangeCudlik,
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        var emailRef = await FirebaseFirestore.instance
                            .collection("users")
                            .where("email", isEqualTo: emailCon.text)
                            .get();

                        if (emailRef.docs.isEmpty) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (c) => const AlertDialog(
                              title: Text("Chyba"),
                              content: Text(
                                  "????et s t??mto emailem neexistuje. Pro p????stup do aplikace mus?? v???? email p??idat admin aplikace."),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          oldDocId = emailRef.docs.first.id;
                          showEmailPage = false;
                        });
                      }
                    },
                    child: const Text("Pokra??ovat"),
                  )
                : OutlinedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailCon.text,
                                password: passwordCon.text)
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(oldDocId)
                              .get()
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "name": value["name"],
                              "favourite": value["favourite"],
                              "isAdmin": value["isAdmin"],
                              "username": value["username"],
                              "email": value["email"],
                            });
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(oldDocId)
                                .delete();
                          });

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HlavniOkno(),
                            ),
                          );
                        }).onError((e, st) {
                          if (e
                              .toString()
                              .contains("firebase_auth/email-already-in-use")) {
                            showDialog(
                              context: context,
                              builder: (c) => const AlertDialog(
                                title: Text("Chyba"),
                                content: Text(
                                    "V???? ????et u?? existuje, pros??m p??ihlaste se"),
                              ),
                            );
                          } else if (e
                              .toString()
                              .contains("firebase_auth/wrong-password")) {
                            showDialog(
                              context: context,
                              builder: (c) => const AlertDialog(
                                title: Text("Chyba"),
                                content: Text("Zad??v??te ??patn?? heslo!"),
                              ),
                            );
                          }

                          return;
                        });
                      }
                    },
                    style: Vzhled.orangeCudlik,
                    child: const Text("Pokra??ovat")),
            const SizedBox(
              height: 10,
            ),
            const Text("nebo"),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignInWidget = true;
                });
              },
              child: const Text(
                "????et m??m vytvo??en, chci se p??ihl??sit",
                style: Vzhled.textBtn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    setState(() {
      isLoading = true;
    });

    String email = emailCon.text;

    if (!emailCon.text.contains("@")) {
      var usernameRef = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: emailCon.text)
          .get();

      if (usernameRef.docs.isEmpty) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (c) => const AlertDialog(
            title: Text("Chyba"),
            content: Text("????et s t??mto jm??nem neexistuje"),
          ),
        );

        setState(() {
          isLoading = false;
        });
        return;
      }

      email = usernameRef.docs.single.data()["email"];
    }

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: passwordCon.text)
        .then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const HlavniOkno()),
          ),
        )
        .onError((e, st) {
      if (e.toString().contains("firebase_auth/user-not-found")) {
        showDialog(
          context: context,
          builder: (c) => const AlertDialog(
            title: Text("Chyba"),
            content: Text("V???? ????et neexistuje"),
          ),
        );
      } else if (e.toString().contains("firebase_auth/wrong-password")) {
        showDialog(
          context: context,
          builder: (c) => const AlertDialog(
            title: Text("Chyba"),
            content: Text("Zad??v??te ??patn?? heslo!"),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (c) => const AlertDialog(
            title: Text("Chyba"),
            content: Text("Nastala nezn??m?? chyba."),
          ),
        );
        debugPrint(e.toString());
      }
    });

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
