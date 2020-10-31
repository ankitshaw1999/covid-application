import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {

final String url="https://api.rootnet.in/covid19-in/stats/latest";

Future<List> data;

Future <List>getData()async{

  var response=await Dio().get(url);
  return response.data['data']['regional'];
}

@override
void initState() {
    // TODO: implement initState
    super.initState();
    data=getData();
  }
Future showcard(String cases,fcases,death,recover) async
{
  await showDialog(
      context:context,
      builder:(BuildContext context)
      {
        return AlertDialog(
          backgroundColor: Color(0xFF363636),
          shape: RoundedRectangleBorder(),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Indian Cases:$cases",style: TextStyle(fontSize: 25,color:Colors.red)),
                Text("Foreigner Cases:$fcases",style: TextStyle(fontSize: 25,color:Colors.white)),
                Text("Total Death:$death",style: TextStyle(fontSize: 25,color:Colors.red)),
                Text("Recovered:$recover",style: TextStyle(fontSize: 25,color:Colors.green)),
              ],
            ),
          ),
        );
      }
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('India Wise Statistic'),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),

        child: FutureBuilder(
            future: data,
            builder: (BuildContext context,SnapShot)
            {
              if(SnapShot.hasData)
              {
                return GridView.builder(

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio:1.0,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 36 ,

                  itemBuilder: (BuildContext context,index)=>SizedBox(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: ()=>showcard(
                        SnapShot.data[index]['totalConfirmed'].toString(),
                        SnapShot.data[index]['confirmedCasesForeign'].toString(),
                        SnapShot.data[index]['deaths'].toString(),
                        SnapShot.data[index]['discharged'].toString(),
                      ),


                      child: Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 5)),
                                Image(image: AssetImage("Image/india.png"),
                                  height:85,
                                  width:85,),
                                Text(SnapShot.data[index]['loc'],style: TextStyle(color:Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),)
                              ],
                            ),

                          ),

                        ),),),


                  ),
                );
              }
              return Center(
                  child:CircularProgressIndicator()
              );
            }
        ),
      ),
    );
  }
}

