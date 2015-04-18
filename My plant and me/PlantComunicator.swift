//
//  PlantComunicator.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//
import Foundation
import SwiftHTTP
import JSONJoy

typealias Date = NSDate

enum DataType: Printable{
    case light
    case humidity
    case temperature
    var description: String {
        switch self {
        case .light: return "luminosity"
        case .humidity: return "humidity"
        case .temperature: return "temp"
        }
    }
}

let pTypes: [String: DataType] = ["temp": DataType.temperature,
    "humidity": DataType.humidity,
    "luminosity": DataType.light]

struct PlantJson: JSONJoy {
    var dataType = [String: PlantData?]()
    init(_ decoder: JSONDecoder) {
        func updt(str: String) {
            dataType.updateValue(PlantData(decoder[str]), forKey: str)
        }
        for key in pTypes.keys {
            updt(key)
        }
    }
}

struct PlantData: JSONJoy {
    var date:String?;
    var value:Int?;
    init(_ decoder: JSONDecoder) {
        date = decoder["date"].string
        value = decoder["value"].integer
    }
}

class PlantComunicator {
    
    let url:String
    
    init(url: String) {
        self.url = url
    }
    
    func recieveData() -> PlantData? {
        var request = HTTPTask()
        var res: PlantData?
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
                res = PlantData(JSONDecoder(str!))
            } else {
                res = nil
            }
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
            res =  nil
        })
        return res
    }
    
    func sendData(type: DataType, value: Int) {
        var request = HTTPTask()
        let params: [String: Int] = [type.description: value]
        request.POST(url, parameters: params
        , success: {(response: HTTPResponse) in
            println("post succeeded with values \(params)")
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("post failed with values \(params)")
        })
        
    }
}