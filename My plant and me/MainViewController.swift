//
//  ViewController.swift
//  My plant and me
//
//  Created by zephyz on 18/04/15.
//  Copyright (c) 2015 purplicious. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    let model = PlantModel(serverURL: "http://46.101.171.226:3000");
    let defaultWaterQuantity = 1;
    let defaultLightExposureTime: Int = 5;
    let defaultTemperatureExposureTime: Int = 1;
    
    func WaterPlant(sender: UIButton) {
        model.waterPlant(defaultWaterQuantity)
    }
    
    func increaseTemperature(sender: UIButton) {
        model.turnOnFan(minutes: defaultTemperatureExposureTime)
    }
    
    func changeLights(sender: UIButton) {
        model.setLights(minutes: defaultLightExposureTime)
    }
    
    @IBAction func turnMeOn(sender: UIButton) {
        changeLights(sender)
        sender.enabled = false
        delay(10) {
            sender.enabled = true
        }
    }
    
    @IBAction func turnFans(sender: UIButton) {
        increaseTemperature(sender)
    }
    @IBAction func waterPlant(sender: UIButton) {
        WaterPlant(sender)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let graphVC = segue.destinationViewController as? GraphDataViewController {
                if let popoverController = graphVC.popoverPresentationController {
                    popoverController.delegate = self
                }
                switch identifier {
                case "Water":
                    graphVC.values = model.humidityHistory.values.array.description
                    graphVC.buttonText = "water plant"
                case "Lights":
                    graphVC.values = model.lightHistory.values.array.description
                    graphVC.buttonText = "turn on lights"
                case "Temperature":
                    graphVC.values = model.temperatureHistory.values.array.description
                    graphVC.buttonText = "increase temperature"
                default:break
                }
            }
        }
    }
}

