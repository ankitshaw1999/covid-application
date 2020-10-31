class Tcases {

  var cases;
  var deaths;
  var recovered;

  //creating constructor
  Tcases({this.cases, this.deaths, this.recovered});

  //storing the data that we are fetching fom api
  factory Tcases.fromJson(final json)
  {
    return Tcases(

      cases: json["cases"],
      deaths: json["deaths"],
      recovered: json["recovered"],
    );
  }
}