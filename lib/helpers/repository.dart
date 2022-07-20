// class Repo {
//   getWeatherDetails(String latitude, String longitude) async {
//     String url = 'https://api.openweathermap.org/data/2.5/forecast?'
//         'lat=$latitude&lon=$longitude&appid=ed760b82998d2740aaf34512a60a70c9';
//     setState(() {
//       isLoading = true;
//     });
//     var response = await http.get(Uri.parse(url));
//     if(response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       setState(() {
//         weather = jsonData;
//         print(weather);
//         isLoading = false;
//       });
//     }else{
//       print('Error Somewhere');
//     }
//   }
// }