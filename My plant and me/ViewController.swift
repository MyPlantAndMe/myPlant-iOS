//
//  ViewController.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = PlantModel(serverURL: "www.google.com/");
    let defaultWaterQuantity = 10;
    let defaultLightExposureTime: Minutes = 60;
    let defaultTemperatureExposureTime: Minutes = 10;
    
    @IBAction func WaterPlant(sender: UIButton) {
        model.waterPlant(defaultWaterQuantity)
    }
    
    @IBAction func increaseTemperatre(sender: UIButton) {
        model.turnOnTemperature(minutes: defaultTemperatureExposureTime)
    }
    @IBAction func changeLights(sender: UIButton) {
        model.setLights(minutes: 60)
    }
    
    
}

