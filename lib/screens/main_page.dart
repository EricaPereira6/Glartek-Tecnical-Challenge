
import 'package:flutter/material.dart';
import 'package:glartek_tecnical_challenge/screens/visual_weather_page.dart';

import '../constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
  }

  String errorMessage = '';

  String dropValue = '';

  final List<String> dropOptions = [
    Constants.cityName[Citys.coimbra]!,
    Constants.cityName[Citys.faro]!,
    Constants.cityName[Citys.leiria]!,
    Constants.cityName[Citys.lisboa]!,
    Constants.cityName[Citys.porto]!
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          children: <Widget>[
            Text(widget.title, style: const TextStyle(fontFamily: 'Lobster'),),
            const SizedBox(width: 5,),
            const Image(image: AssetImage(Constants.weatherIcon), width: 50, height:50)
          ],
        ),
        backgroundColor: Constants.bgColorAppBar,
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: MediaQuery.of(context).size.width - 150,
                  child: const Image(image: AssetImage(Constants.cityImg)),),

                SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child:
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: const Text('Selecionar Cidade'),
                      decoration: InputDecoration(
                          label: const Text('Cidade'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )),
                      value: (dropValue.isEmpty) ? null : dropValue,
                      onChanged: (selected) => setState(() {
                        dropValue = selected!;
                        errorMessage = '';
                      }),
                      items: dropOptions.map((op) => DropdownMenuItem(
                          value: op,
                          child: Text(op)
                      )).toList(),
                    )),

                const SizedBox(height: 30,),

                ElevatedButton(
                  onPressed: () async {
                    if (dropValue.isEmpty) {
                      setState(() {
                        if (errorMessage == '') {
                          errorMessage = "Selecione uma cidade";
                        }
                      });
                    }
                    else {
                      Citys c = Constants.cityName.keys.firstWhere((v) =>
                      Constants.cityName[v] == dropValue.toString());

                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) => VisualWeatherPage(city: c)));

                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 250, 40)),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text('Pesquisar'),
                ),
              ],),
            ),

            Center(child: Text(errorMessage, style: const TextStyle(fontSize: 15,
                color: Constants.errorDarkColor),),),

            const SizedBox(height: 15,)
          ],),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.

    );
  }
}
