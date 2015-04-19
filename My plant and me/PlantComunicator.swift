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
    var date:Int?;
    var value:Int?;
    init(_ decoder: JSONDecoder) {
        date = decoder["date"].integer
        value = decoder["value"].integer
    }
}

struct DataHistory: JSONJoy {
    var history: [PlantData?] = [PlantData?]()
    init(_ decoder: JSONDecoder) {
        if let datas = decoder["history"].array {
            for dataDecoder in datas {
                history.append(PlantData(dataDecoder))
            }
        }
    }
}

func historyAsDict(history: DataHistory?) -> [Date: Int] {
    if history != nil {
        var dict = [Date: Int]()
        for data in history!.history {
            if data != nil{
                dict.updateValue(data!.value!, forKey: data!.date!)
            }
        }
        return dict
    } else {
        return [Date: Int]()
    }
}

class PlantComunicator {
    
    let url:String
    
    init(url: String) {
        self.url = url
    }
    
    func recieveDataHistory(path: String) -> DataHistory? {
        var request = HTTPTask()
        var history: DataHistory? = nil
        request.responseSerializer = JSONResponseSerializer()
        request.GET(url + path, parameters: nil, success: {(response: HTTPResponse) in
            if let result: AnyObject = response.responseObject{
                history = DataHistory(JSONDecoder(result))
            }
            println("succesfully connected to server")
        },failure: {(error: NSError, response: HTTPResponse?) in
            println("error: \(error)")
        })
        return history
    }
    
    func sendData(type: String, value: Int) {
        var request = HTTPTask()
        request.requestSerializer = HTTPRequestSerializer()
        request.requestSerializer.headers["Content-Type"] = "application/x-www-form-urlencoded"
        let params: [String: Int] = ["duration": value]
        request.POST(url+"/actions/"+type, parameters: params
        , success: {(response: HTTPResponse) in
            println("post succeeded with values \(params) and response \(response)")
        },failure: {(error: NSError, response: HTTPResponse?) in
            let r = response?.description ?? "no response"
            println("post failed with values \(params) and \(r)")
        })
    }
}