//
//  PlantComunicator.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import Foundation

class PlantComunicator {
//    let url = NSURL(string:"")
//    let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
//
//    var request = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 2.0)
//    request.HTTPMethod = "POST"
    
    typealias Date = NSDate
    
    enum dataType {
        case Light
        case Humidity
        case Temperature
    }
    
    struct PlantData {
        var type:dataType;
        var date:Date;
        var value:Int;
    }
    
    func request() -> String {
        return ""
    }
    
    func parseRequest(json: String) -> [PlantData]{
        return PlantData(
            .type = dataType.Light
            .date = NSDate()
            .value = 0);
    }
}