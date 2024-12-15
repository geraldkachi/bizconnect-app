import 'dart:convert';

class StressSuggestionsResponse {
  final bool? success;
  final Message? message;
  final Data? data;

  StressSuggestionsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory StressSuggestionsResponse.fromJson(Map<String, dynamic> json) {
    return StressSuggestionsResponse(
      success: json['success'],
      message: Message.fromJson(json['message']),
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message!.toJson(),
      'data': data!.toJson(),
    };
  }
}

class Message {
  final int code;
  final String desc;

  Message({
    required this.code,
    required this.desc,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      code: json['code'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'desc': desc,
    };
  }
}

class Data {
  final List<Suggestion> suggestions;

  Data({required this.suggestions});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      suggestions: (json['suggestions'] as List)
          .map((e) => Suggestion.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestions': suggestions.map((e) => e.toJson()).toList(),
    };
  }
}

class Suggestion {
  final String formattedAddress;
  final Geometry geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final String placeId;
  final String reference;
  final List<String> types;

  Suggestion({
    required this.formattedAddress,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.placeId,
    required this.reference,
    required this.types,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
      icon: json['icon'],
      iconBackgroundColor: json['icon_background_color'],
      iconMaskBaseUri: json['icon_mask_base_uri'],
      name: json['name'],
      placeId: json['place_id'],
      reference: json['reference'],
      types: List<String>.from(json['types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formatted_address': formattedAddress,
      'geometry': geometry.toJson(),
      'icon': icon,
      'icon_background_color': iconBackgroundColor,
      'icon_mask_base_uri': iconMaskBaseUri,
      'name': name,
      'place_id': placeId,
      'reference': reference,
      'types': types,
    };
  }
}

class Geometry {
  final LocationG location;
  final Viewport viewport;

  Geometry({required this.location, required this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: LocationG.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'viewport': viewport.toJson(),
    };
  }
}

class LocationG {
  final double lat;
  final double lng;

  LocationG({required this.lat, required this.lng});

  factory LocationG.fromJson(Map<String, dynamic> json) {
    return LocationG(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Viewport {
  final LocationG northeast;
  final LocationG southwest;

  Viewport({required this.northeast, required this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: LocationG.fromJson(json['northeast']),
      southwest: LocationG.fromJson(json['southwest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}
