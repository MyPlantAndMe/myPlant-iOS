//
//  ViewController.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = PlantModel(serverURL: "http://46.101.171.226:3000");
    let defaultWaterQuantity = 10;
    let defaultLightExposureTime: Int = 60;
    let defaultTemperatureExposureTime: Int = 10;
    
    @IBAction func WaterPlant(sender: UIButton) {
        model.waterPlant(defaultWaterQuantity)
    }
    
    @IBAction func increaseTemperatre(sender: UIButton) {
        model.turnOnFan(minutes: defaultTemperatureExposureTime)
    }
    @IBAction func changeLights(sender: UIButton) {
        model.setLights(minutes: 60)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let graphVC = segue.destinationViewController as? GraphDataViewController {
                switch identifier {
                case "Water":
                    graphVC.text = model.humidityHistory.description
                case "Lights":
                    graphVC.text = model.lightHistory.description
                case "Temperature":
                    graphVC.text = model.temperatureHistory.description
                default:break
                }
            }
        }
    }
}

