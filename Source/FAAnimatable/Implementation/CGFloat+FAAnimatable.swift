//
//  CGFloat+FAAnimatable.swift
//  FlightAnimator
//
//  Created by Anton Doudarev on 2/24/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat : FAAnimatable {
    
    public typealias T = CGFloat
    
    public func magnitudeValue() -> CGFloat {
        return sqrt((self * self))
    }
    
    public func magnitudeToValue<T : FAAnimatable>(_ toValue:  T) -> CGFloat {
        return self - toValue.magnitudeValue()
    }
    
    public func interpolatedValue<T : FAAnimatable>(_ toValue : T, progress : CGFloat) -> AnyObject {
        return interpolateCGFloat(self, end: (toValue as! CGFloat), progress: progress).valueRepresentation()
    }
    
    public func springVelocity(_ springs : Dictionary<String, FASpring>, deltaTime : CGFloat) -> CGPoint {
        if let currentFloatVelocity = springs[SpringAnimationKey.CGFloat]?.velocity(deltaTime) {
           return  CGPoint(x: currentFloatVelocity, y: currentFloatVelocity)
        }
        
        return CGPoint.zero
    }
    public func interpolationSprings<T : FAAnimatable>(_ toValue : T, initialVelocity : Any, angularFrequency : CGFloat, dampingRatio : CGFloat) -> Dictionary<String, FASpring> {
        var springs = Dictionary<String, FASpring>()
        
        if let startingVelocity = initialVelocity as? CGFloat {
            let floatSpring = FASpring(finalValue: (toValue as! CGFloat),
                                       initialValue:  self,
                                       positionVelocity: startingVelocity,
                                       angularFrequency:angularFrequency,
                                       dampingRatio: dampingRatio)
            
            springs[SpringAnimationKey.CGFloat] = floatSpring
        }
        
        return springs
    }
    
    public func interpolatedSpringValue<T : FAAnimatable>(_ toValue : T, springs : Dictionary<String, FASpring>, deltaTime : CGFloat) -> AnyObject {
        return springs[SpringAnimationKey.CGFloat]!.updatedValue(deltaTime).valueRepresentation()
    }
    
    public func valueRepresentation() -> AnyObject {
        return NSNumber(value: Float(self))
    }
}
