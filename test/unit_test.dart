import 'package:flutter_test/flutter_test.dart';
import 'package:task_weather_app/helpers/controller.dart';

WeatherController con = WeatherController();

void main() {
  test("Fetch API", () async {
    bool done = false;
    var fetch = await con.getWeatherDetails('27.2046', '77.4977');
    if(fetch == null) {
      done = true;
    }
    expect(done, true);
  });
}