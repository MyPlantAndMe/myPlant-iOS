//
//  plantModel.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import Foundation

typealias Date = Int;

class PlantModel {
    
    
    let communicator: PlantComunicator
    let humidityHistory: [Date: Int]
    let lightHistory: [Date: Int]
    let temperatureHistory: [Date: Int]
    
    init(serverURL: String) {
        communicator = PlantComunicator(url: serverURL)
        humidityHistory = historyAsDict(communicator.recieveDataHistory("/humidity"))
        lightHistory = historyAsDict(communicator.recieveDataHistory("/luminosity"))
        temperatureHistory = historyAsDict(communicator.recieveDataHistory("/temp"))
    }
    
    func waterPlant(quantity: Int) {
        
        communicator.sendData("water", value: quantity)
    }
    
    func setLights(minutes duration: Int) {
        communicator.sendData("lights", value: duration)
    }
    
    func turnOnFan(minutes duration: Int) {
        communicator.sendData("fan", value: duration)
    }
}