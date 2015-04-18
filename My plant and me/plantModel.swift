//
//  plantModel.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import Foundation

typealias Minutes = Int;

class PlantModel {
    
    let communicator: PlantComunicator
    
    init(serverURL: String) {
        communicator = PlantComunicator(url: serverURL)
    }
    
    func waterPlant(quantity: Int) {
        communicator.sendData(DataType.humidity, value: quantity)
    }
    
    func setLights(minutes duration: Minutes) {
        communicator.sendData(DataType.light, value: duration)
    }
    
    func turnOnTemperature(minutes duration: Minutes) {
        communicator.sendData(DataType.temperature, value: duration)
    }
}