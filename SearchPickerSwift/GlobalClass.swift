////GlobalClass.swift
//MezzanHoldingCoDelivery
////Created by technoduce2 on 4/3/18.
//Copyright © 2018 technoduce2. All rights reserved.//

import UIKit

class GlobalClass: NSObject {
  
   static let sharedInstance: GlobalClass = GlobalClass()
    func animateViewMoving (up:Bool, moveValue :CGFloat, view:UIView){
        let movementDistance:CGFloat = -moveValue
        let movementDuration: Double = 0.3
        var movement:CGFloat = 0
        if up{
            movement = movementDistance
        }else{
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        view.frame = view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
