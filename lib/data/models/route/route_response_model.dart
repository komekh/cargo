import 'dart:convert';

import '../../../domain/domain.dart';
import 'route_model.dart';

RouteResponseModel routeResponseModelFromJson(String str) => RouteResponseModel.fromJson(json.decode(str));

class RouteResponseModel extends RouteResponse {
  RouteResponseModel({
    required super.routes,
  });

  factory RouteResponseModel.fromJson(List<dynamic> jsonList) {
    return RouteResponseModel(
      routes: jsonList.map((json) => RouteModel.fromJson(json)).toList(),
    );
  }
}
