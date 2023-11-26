// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ValorDolar extends StatefulWidget {
  const ValorDolar({Key? key}) : super(key: key);

  @override
  State<ValorDolar> createState() => _ValorDolarState();
}

class _ValorDolarState extends State<ValorDolar> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  var unidad = 'unidad';
  var dato = 'valor';
  var desde = 'desde';
  var hasta = 'hasta';

  @override
  void initState() {
    super.initState();
    getDolar();
  }

  Future<void> getDolar() async {
    final response = await http
        .get(Uri.parse('https://www.datos.gov.co/resource/32sa-8pi3.json'));
    if (response.statusCode == 200) {
      // Map<String, dynamic> decodedData = json.decode(response.body);
      List decodedData = json.decode(response.body);
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listando datos...')),
        );
        data = decodedData;
        filteredData.addAll(data);
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al listar los datos...')),
        );
      });
    }

    for (var i in data) {
      unidad = i['unidad'].toString();
      dato = i['valor'].toString();
      desde = i['vigenciadesde'].toString();
      hasta = i['vigenciahasta'].toString();
      break;
    }
  }

  var selUser = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Center(child: Text('Valor del Dolar')),
        backgroundColor: const Color.fromARGB(255, 0, 100, 0),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 200, 250, 210),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.money,
                                  color: Color.fromARGB(255, 0, 100, 0),
                                ),
                              ),
                              const Text(
                                'Valor del dolar hoy: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('$dato $unidad'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: Color.fromARGB(255, 0, 100, 0),
                                ),
                              ),
                              const Text(
                                'Vigencia desde: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(desde),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: Color.fromARGB(255, 0, 100, 0),
                                ),
                              ),
                              const Text(
                                'Vigencia hasta: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(hasta),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
              // ListView.builder(
              //   itemCount: filteredData.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       title: Card(
              //         elevation: 0,
              //         color: const Color.fromARGB(30, 0, 250, 50),
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(
              //                   top: 10, right: 10, left: 10, bottom: 5),
              //               child: Row(
              //                 children: [
              //                   const Padding(
              //                     padding: EdgeInsets.only(right: 5),
              //                     child: Icon(
              //                       Icons.money,
              //                       color: Color.fromARGB(255, 0, 100, 0),
              //                     ),
              //                   ),
              //                   Text('Valor del dolar: ' +
              //                       filteredData[index]['valor'] +
              //                       ' ' +
              //                       filteredData[index]['unidad']),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
              ),
        ],
      ),
    );
  }
}
