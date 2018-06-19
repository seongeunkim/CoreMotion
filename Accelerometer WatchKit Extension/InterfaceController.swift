//
//  InterfaceController.swift
//  Accelerometer WatchKit Extension
//
//  Created by Seong Eun Kim on 19/06/18.
//  Copyright © 2018 Seong Eun Kim. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {
    
    let motionManager = CMMotionManager()

    @IBOutlet var accX: WKInterfaceLabel!
    @IBOutlet var accY: WKInterfaceLabel!
    @IBOutlet var accZ: WKInterfaceLabel!
    
    @IBOutlet var gyroX: WKInterfaceLabel!
    @IBOutlet var gyroY: WKInterfaceLabel!
    @IBOutlet var gyroZ: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        accX?.setText("X: 3")
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // set sampling rate
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
        }
        //if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.2
        //}

        // start getting updates
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                self.outputAccelerationData(acceleration: data.acceleration)
            }
            
        }
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                self.outputGyroData(rotation: data.rotationRate)
            }
        }
//        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (accData: CMAccelerometerData?, error: NSError?) -> Void in
//            if let accData = accData {
//                //self.outputAccelerationData(acceleration: accData.acceleration)
//            }
//        } as! CMAccelerometerHandler)

//        motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData: CMGyroData?, error: NSError?) -> Void in
//
//        } as! CMGyroHandler)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func outputAccelerationData(acceleration: CMAcceleration) {
        accX?.setText("accX: \(acceleration.x).2fg")
        accY?.setText("accY: \(acceleration.y).2fg")
        accZ?.setText("accZ: \(acceleration.y).2fg")
    }
    
    func outputGyroData(rotation: CMRotationRate) {
        gyroX?.setText("gyroX: \(rotation.x).2fr/s")
        gyroY?.setText("gyroY: \(rotation.y).2fr/s")
        gyroZ?.setText("gyroZ: \(rotation.z).2fr/s")
    }

}
