import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:corona/world.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Tcases.dart';
import 'world.dart';
import 'india.dart';
import 'summary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //declaring the API site
    final String url="https://corona.lmao.ninja/v2/all";

//Building Function To get Data From Api


Future<Tcases> getJasonData() async{

  var response=await http.get(
    Uri.encodeFull(url),
  );

  if(response.statusCode==200)
    {
      final convertDataJason =jsonDecode(response.body);

      //Returning Class fucntion Tcases
      return Tcases.fromJson(convertDataJason);
    }

  else
    {
      throw Exception('Try To Reload Again');
    }
}

    @override void initState(){
        super.initState();
        this.getJasonData();

      }

      navigateToCountry()async
      {
        await Navigator.push(context, MaterialPageRoute(
            builder:(context)=>world()
        ));
      }
  navigateToIndia()async
  {
    await Navigator.push(context, MaterialPageRoute(
        builder:(context)=>India()
    ));
  }

  navigateToSummary()async
  {
    await Navigator.push(context, MaterialPageRoute(
        builder:(context)=>Sum_india()
    ));
  }

  navigateToWho(url) async
  {
      if(await canLaunch(url))
        {
          await launch(url);
        }
      else
        {
          Text("Link Not Working $url");
        }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
        backgroundColor: Colors.green[900],
      ),

      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("Stay",style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight:FontWeight.bold),),

                        Card(color: Color(0xFFfe9900),
                          child: Text("Home",style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight:FontWeight.bold),),
                        ),

                      ],
                    ),
                  ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('World Wide Statistics',style: TextStyle(fontSize: 16.0,color:Colors.white),),
                  Padding(padding: EdgeInsets.only(top: 10.0)),

                  OutlineButton(
                    color: Colors.blue,
                    borderSide:BorderSide(color: Color(0xFFfe9900)),
                    onPressed: ()=>navigateToSummary(),
                    child: Text('India Statistic',style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Color(0xFFfe9900))),
                  )
                ],
              ),
              //Fetching Data
              FutureBuilder<Tcases>(
                future: getJasonData(),
                builder: (BuildContext context,SnapShot)
                {
                  if (SnapShot.hasData) {
                    final covid = SnapShot.data;
                    return Column(
                      children: [
                        Card(
                          color: Color(0xFF292929),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Text("${covid.cases}", style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),

                                  Text("${covid.deaths}", style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),

                                  Text("${covid.recovered}", style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),

                          ),
                        )
                      ],

                    );
                  }
                  else if(SnapShot.hasError)
                    {
                      return Text(SnapShot.error.toString());
                    }
                  else return CircularProgressIndicator();
                },
              ),
             // Padding(padding: EdgeInsets.only(top: 20)),
              Container(child:Card(color: Color(0xFF292929),
                child:ListTile(title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Total Cases", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),

                    Text("Deaths", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),

                    Text("Recovered", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),

                  ],

                ),
                )
              )
              ),
              Padding(padding: EdgeInsets.only(top :20.0)),
              Container(
                  child:Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Card(
                            child :Container(color: Colors.green[900],
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[


                                          Padding(padding: EdgeInsets.only(top :20.0)),

                                          Image(image: AssetImage("Image/india.png"),
                                            height: 90,
                                            width: 90
                                            ,
                                          ),
                                          Padding(padding: EdgeInsets.all(10)),
                                          RaisedButton(color: Colors.red[900],
                                            //borderSide: BorderSide(color : Colors.grey[900],),

                                            onPressed: ()=>navigateToIndia(),

                                            child : Text("          Indian \n Statewise Statistics",style: TextStyle(fontSize: 15,color:Colors.grey[900],fontWeight: FontWeight.bold),),
                                          ),

                                        ]))


                            ) ),
                        Card(
                            child :Container(color: Colors.green[900],
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[


                                          Padding(padding: EdgeInsets.only(top :20.0)),

                                          Image(image: AssetImage("Image/world.png"),
                                            height: 90,
                                            width: 90
                                            ,
                                          ),
                                          Padding(padding: EdgeInsets.all(10)),
                                          RaisedButton(color: Colors.red[900],

                                           // borderSide: BorderSide(color : Color(0xFFfe9900)),

                                            onPressed: ()=>navigateToCountry(),

                                            child : Text("CountryStatistics",style: TextStyle(fontSize: 15,color:Colors.grey[900],fontWeight: FontWeight.bold),),
                                          ),

                                        ]))


                            ) ),

                      ]
                  ) ),

              ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>navigateToWho("https://www.who.int/news-room/releases"),
        label: Text("Myth Buster",style: TextStyle(fontSize: 20,color:Colors.black,fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.find_in_page ),
        backgroundColor: Color(0xFFfe9900),
      ),
    );
  }
}
