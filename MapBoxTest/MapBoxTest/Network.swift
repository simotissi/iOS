//
//  Network.swift
//  MapBoxTest
//
//  Created by Simone Tissi on 16/04/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import Foundation
import Moya

public enum MapBoxAPI {
  // Login
  case forwardGeo(address:String)

}

extension MapBoxAPI: TargetType, AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? {
        switch self {
        case .forwardGeo: return .bearer
        }
    }
  
  public var validationType: ValidationType { return ValidationType.successCodes }

  var parameterEncoding: ParameterEncoding {
      
      if method == .get {
          return URLEncoding.httpBody
      }
      
      return JSONEncoding.default
  }
  
  public var baseURL: URL {
    return URL(string: "https://api.mapbox.com")!
  }
  
  public var path: String {
    switch self{
      // Login
      case .forwardGeo(let address): return "/geocoding/v5/mapbox.places/\(address).json"
    }
  }
  
  public var method: Moya.Method {
    switch self{
      // Login
      case .forwardGeo: return .get
    }
  }
  
  public var sampleData: Data{
    return Data()
  }
  
  public var task: Task{
    switch self{
    case .forwardGeo(let address):
        let parameters: [String:Any] = ["search-text": address]
      return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
  }
  
  public var headers: [String : String]?{
    return [
      "Accept": "application/json",
      "Content-Type": "application/json",
      "cache-control": "no-cache"
    ]
  }
}
