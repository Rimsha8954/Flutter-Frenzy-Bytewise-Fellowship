Future<String> fetchWeatherReport() async{
  return await Future.delayed(
      Duration(milliseconds: 3),
      () => ' 33°C',
  );
}