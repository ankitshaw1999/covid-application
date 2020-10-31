import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'Tindia.dart';
import 'dart:convert';

class Sum_india extends StatefulWidget {
  @override
  _Sum_indiaState createState() => _Sum_indiaState();
}

class _Sum_indiaState extends State<Sum_india>{
  final String url="https://api.rootnet.in/covid19-in/stats/latest";

  @override
  void initState() {
    super.initState();

    this.getJsonData();


  }

  Future <Ticases> getJsonData() async
  {
    var response = await http.get(
      Uri.encodeFull(url),

    );


    if (response.statusCode==200)
    {
      final convertDataJson = jsonDecode(response.body)['data']['summary'];

      return Ticases.fromJson(convertDataJson);
    }
    else{
      throw Exception('Try to  Reload Page');
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Indian COVID-19 Statistics'),
          backgroundColor: Colors.green[900],

        ),
        backgroundColor: Colors.black,
        body:Container(
            child : Center(
              child :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: <Widget>[

                    Card(color: Color(0xFF292929),
                        child : ListTile(


                            title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children : <Widget>[


                                  Text("Total Cases ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("Deaths",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("Recoveries",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                                ]) )
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),

                    FutureBuilder<Ticases>(

                        future: getJsonData(),
                        builder: (BuildContext context,SnapShot){


                          if(SnapShot.hasData)
                          {
                            final covid = SnapShot.data;
                            return Column(
                                children : <Widget>[
                                  Card(color: Color(0xFF292929),
                                      child : ListTile(


                                          title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children : <Widget>[


                                                Text("${covid.total} ",style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),),
                                                Text("${covid.deaths}",style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
                                                Text("${covid.discharged}",style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),

                                              ]

                                          ) )
                                  )]);
                          }

                          else if(SnapShot.hasError)
                          {
                            return Text(SnapShot.error.toString());
                          }

                          return CircularProgressIndicator();

                        }
                    ),

                  ]
              ),)
        )
    );
  }}