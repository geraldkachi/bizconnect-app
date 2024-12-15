class GooglePlaceResult {
  final String businessStatus;
  final String formattedAddress;
  final Geometry geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHours? openingHours;
  final List<Photo>? photos;
  final String placeId;
  final PlusCode plusCode;
  final double? rating;
  final String reference;
  final List<String> types;
  final int? userRatingsTotal;

  GooglePlaceResult({
    required this.businessStatus,
    required this.formattedAddress,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    this.openingHours,
    this.photos,
    required this.placeId,
    required this.plusCode,
    this.rating,
    required this.reference,
    required this.types,
    this.userRatingsTotal,
  });

  factory GooglePlaceResult.fromJson(Map<String, dynamic> json) {
    return GooglePlaceResult(
      businessStatus: json['business_status'],
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
      icon: json['icon'],
      iconBackgroundColor: json['icon_background_color'],
      iconMaskBaseUri: json['icon_mask_base_uri'],
      name: json['name'],
      openingHours: json['opening_hours'] != null
          ? OpeningHours.fromJson(json['opening_hours'])
          : null,
      photos: json['photos'] != null
          ? List<Photo>.from(json['photos'].map((x) => Photo.fromJson(x)))
          : [],
      placeId: json['place_id'],
      plusCode: PlusCode.fromJson(json['plus_code']),
      rating: json['rating']?.toDouble(),
      reference: json['reference'],
      types: List<String>.from(json['types']),
      userRatingsTotal: json['user_ratings_total'],
    );
  }
}

class Geometry {
  final LocationG location;
  final Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: LocationG.fromJson(json['location']),
      viewport: Viewport.fromJson(json['viewport']),
    );
  }
}

class LocationG {
  final double lat;
  final double lng;

  LocationG({required this.lat, required this.lng});

  factory LocationG.fromJson(Map<String, dynamic> json) {
    return LocationG(lat: json['lat'], lng: json['lng']);
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
}

class OpeningHours {
  final bool openNow;

  OpeningHours({required this.openNow});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(openNow: json['open_now']);
  }
}

class Photo {
  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json['height'],
      htmlAttributions: List<String>.from(json['html_attributions']),
      photoReference: json['photo_reference'],
      width: json['width'],
    );
  }
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json['compound_code'],
      globalCode: json['global_code'],
    );
  }
}
