import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:tech_blog/models/currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: Text("AppBar"), actions: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Icon(Icons.menu),
//           )
//         ],),
//         body: Center(
//           child: Text("I am learning Flutter... \n Hello World"),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // Farsi
        // Locale('en'), // English
        // Locale('es'), // Spanish
      ],
      theme: ThemeData(
        fontFamily: 'Vazirmatn',
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));
    developer.log(value.body, name: "value in Func getResponse");
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showSnackBar(context, "بروزرسانی اطلاعات با موفقیت انجام شد");
        developer.log(
          value.body,
          name: "value statusCode in getResponse",
          error: convert.jsonDecode(value.body),
        );
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(
                Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"],
                ),
              );
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    developer.log("initState", name: "Life Cycle");
    getResponse(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    developer.log("didChangeDependencies", name: "Life Cycle");
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    developer.log("didUpdateWidget", name: "Life Cycle");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    developer.log("deactivate", name: "Life Cycle");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    developer.log("dispose", name: "Life Cycle");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(width: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset("assets/images/money-bag-30.png"),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "قیمت به روز ارز",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/images/menu-30.png"),
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/faq.png"),
                  SizedBox(width: 4.0),
                  Text(
                    "نرخ ارز آزاد چیست؟",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را باهم تبادل می نمایند.",
                style: Theme.of(context).textTheme.bodySmall,
                // textDirection: TextDirection.rtl,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Container(
                  width: double.infinity, // for responsive (Alpha)
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                    color: Color.fromARGB(255, 130, 130, 130),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "نام آزاد ارز",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "قیمت",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "تغییر",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/2,
                child: listFutureBuilder(context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/16,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 232, 232),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/16,
                        child: TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Color.fromARGB(255, 202, 193, 255),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                ),
                          ),
                          onPressed: () {
                            currency.clear();
                            listFutureBuilder(context);
                            setState(() {
                              getResponse(context);
                            });
                            _showSnackBar(
                              context,
                              "بروزرسانی با موفقیت انجام شد.",
                            );
                          },
                          icon: Icon(
                            CupertinoIcons.refresh_bold,
                            color: Colors.black,
                          ),
                          label: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text(
                              "بروزرسانی",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                      ),
                      Text("آخرین بروزرسانی ${_getTime()}"),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: getResponse(context),
      // **** ? $$$$ : @@@@
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: BouncingScrollPhysics(), // for best Animation
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: PriceItems(position, currency),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Adds(),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: null,
                ),
              );
      },
    );
  }

  String _getTime() {
    DateTime now = DateTime.now();
    return DateFormat('kk:mm:ss').format(now);
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: Theme.of(context).textTheme.headlineSmall),
      backgroundColor: Colors.green,
    ),
  );
}

class PriceItems extends StatelessWidget {
  int position;
  List<Currency> currency;
  PriceItems(this.position, this.currency, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 1.0, color: Colors.grey)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[position].title!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            faNumber(currency[position].price.toString()),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            faNumber(currency[position].changes.toString()),
            style: currency[position].status == "n"
                ? Theme.of(context).textTheme.labelSmall
                : Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class Adds extends StatelessWidget {
  const Adds({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 1.0, color: Colors.grey)],
        color: Colors.red,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("تبلیغات", style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}

String faNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['٠', '١', '٢', '٣', '۴', '۵', '۶', '٧', '٨', '٩'];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
