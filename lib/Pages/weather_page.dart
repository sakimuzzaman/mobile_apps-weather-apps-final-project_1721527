import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/weather_model.dart';
import 'package:flutter_application_1/services/weather_services.dart';
import 'package:lottie/lottie.dart';


 class WeatherPage extends StatefulWidget {
  const WeatherPage ({super.key});
  
  

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}


class _WeatherPageState extends State<WeatherPage> {


// api key

final _weatherService = WeatherService('8d6905bbb340c7747e5a722e4897ebd0');
Weather? _weather;


// fetch weather 
_fetchWeather() async {
 
 //get the current city
 String cityName = await _weatherService.getCurrentCity();
 // get weather for city
 try {
   final  weather = await _weatherService.getWeather(cityName);
   setState(() {
     _weather = weather;
   });
 }

//any error
 catch (e) {
  print(e);
 }

}

// initial state
@override
void initState() {
  super.initState();

//fetch weather on startup
 
_fetchWeather();

}

 


// weather animation

String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) return 'assets/sunny.json'; //Default to sunny

  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'smoke':
    case 'haze':
    case 'dusk':
    case 'fog':
    return 'assets/sunny.json';
    case 'rain':
    case 'drizlle':
    case 'shower rain':
    case 'thunderstorm':
    return 'assets/sunny.json';
    case 'clear':
     return 'assets/sunny.json';
    default:
      return 'assets/cloudy.json';
    
  } 


}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: 

      
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Text(
            'This is our First Weather Apps',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              backgroundColor: Colors.yellow,
            ),
            
            ),
          
          //city name
           Text( _weather?.cityName ?? "loading city.."),
           
           //animation
           Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

           //temp
           //Text(_weather!.temperature ?? '°C'),
           
          //weather condition
          Text(_weather?.mainCondition ?? "")
          

        ]),
      );
    
  }
}





//Lottie.asset('assets/sunny.json'),