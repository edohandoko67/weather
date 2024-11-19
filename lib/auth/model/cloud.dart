class Cloud {
  Locations? locations;
  Currents? currents;
  Forecast? forecast;

  Cloud({
    this.currents,
    this.locations,
    this.forecast,
});

  factory Cloud.fromJson(Map<String, dynamic> json) {
    return Cloud(
      currents: json['current'] != null
          ? Currents.fromJson(json['current'])
          : null,
      locations: json['location'] != null
          ? Locations.fromJson(json['location'])
          : null,
      forecast: json['forecast'] != null
          ? Forecast.fromJson(json['forecast'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': currents?.toJson(),
      'location': locations?.toJson(),
      'forecast': forecast?.toJson(),
    };
  }
}

class Locations {
  String? name;
  String? region;
  String? country;
  String? localtime;
  Locations({
    this.name,
    this.country,
    this.region,
    this.localtime
});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      name: json['name'] ?? 'null',
      region: json['region'] ?? 'null',
      country: json['country'] ?? 'null',
      localtime: json['localtime'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'localtime': localtime
    };
  }
}

class Currents {
  double? celcius;
  double? wind;
  double? feelsCelcius;
  double? uv;
  int? humidity;
  Conditions? conditions;

  Currents({
    this.celcius,
    this.feelsCelcius,
    this.uv,
    this.wind,
    this.conditions,
    this.humidity,
});

  factory Currents.fromJson(Map<String, dynamic> json) {
    return Currents(
      celcius: json['temp_c'] ?? '0.0 C',
      wind: json['wind_kph'] ?? '0.0 kph',
      feelsCelcius: json['feelslike_c'] ?? '0.0 C',
      uv: json['uv'] ?? '',
      conditions: json['condition'] != null
          ? Conditions.fromJson(json['condition'])
          : null,
      humidity: json['humidity'] ?? 0
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'temp_c': celcius,
      'wind_kph': wind,
      'feelslike_c': feelsCelcius,
      'uv': uv,
      'condition': conditions?.toJson(),
      'humidity': humidity,
    };
  }
}

class Conditions {
  String? txt;
  String? icon;

  Conditions({
    this.icon,
    this.txt
});

  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      txt: json['text'] ?? '',
      icon: json['icon'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': txt,
      'icon': icon
    };
  }
}

class Forecast {
  List<ForecastDay>? forecastday;

  Forecast({
    this.forecastday,
});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List<dynamic>)
          .map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forecastday': forecastday?.map((e) => e.toJson()).toList(),
    };
  }
}

class ForecastDay {
  List<Hour>? hours;
  Astro? astro;

  ForecastDay({
    this.hours,
    this.astro,
});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      hours: (json['hour'] as List<dynamic>)
          .map((e) => Hour.fromJson(e as Map<String, dynamic>))
          .toList(),
      astro: json['astro'] != null
        ? Astro.fromJson(json['astro'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hours?.map((e) => e.toJson()).toList(),
      'astro': astro?.toJson(),
    };
  }
}

class Hour {
  String? time;
  double? temp_c;
  int? humidity;
  ConditionWeather? txt;

  Hour({
    this.humidity,
    this.temp_c,
    this.time,
    this.txt,
});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      humidity: json['humidity'] ?? 0,
      temp_c: json['temp_c'] ?? '',
      time: json['time'] ?? '',
      txt: json['condition'] != null
        ? ConditionWeather.fromJson(json['condition'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'humidity': humidity,
      'temp_c': temp_c,
      'time': time,
      'condition': txt?.toJson(),
    };
  }
}

class ConditionWeather {
  String? txtWeather;

  ConditionWeather({
    this.txtWeather,
});

  factory ConditionWeather.fromJson(Map<String, dynamic> json) {
    return ConditionWeather(
      txtWeather: json['text'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': txtWeather
    };
  }
}

class Astro {
  String? sunrise;
  String? sunset;

  Astro({
    this.sunrise,
    this.sunset,
});

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}