class Cloud {
  Locations? locations;
  Currents? currents;

  Cloud({
    this.currents,
    this.locations
});

  factory Cloud.fromJson(Map<String, dynamic> json) {
    return Cloud(
      currents: json['current'] != null
          ? Currents.fromJson(json['current'])
          : null,
      locations: json['location'] != null
          ? Locations.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': currents?.toJson(),
      'location': locations?.toJson()
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
  Conditions? conditions;

  Currents({
    this.celcius,
    this.feelsCelcius,
    this.uv,
    this.wind,
    this.conditions
});

  factory Currents.fromJson(Map<String, dynamic> json) {
    return Currents(
      celcius: json['temp_c'] ?? '0.0 C',
      wind: json['wind_kph'] ?? '0.0 kph',
      feelsCelcius: json['feelslike_c'] ?? '0.0 C',
      uv: json['uv'] ?? '',
      conditions: json['condition'] != null
          ? Conditions.fromJson(json['condition'])
          : null
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'temp_c': celcius,
      'wind_kph': wind,
      'feelslike_c': feelsCelcius,
      'uv': uv,
      'condition': conditions?.toJson()
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