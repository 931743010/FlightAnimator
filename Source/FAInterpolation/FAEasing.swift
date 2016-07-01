//
//  FAEasingFunction.swift
//  FlightAnimator
//
//  Created by Anton Doudarev on 4/22/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit

public enum FAEasing : Equatable {
    case Linear
    case LinearSmooth
    case LinearSmoother
    case InSine
    case OutSine
    case InOutSine
    case InQuadratic
    case OutQuadratic
    case InOutQuadratic
    case InCubic
    case OutCubic
    case InOutCubic
    case InQuartic
    case OutQuartic
    case InOutQuartic
    case InQuintic
    case OutQuintic
    case InOutQuintic
    case InExponential
    case OutExponential
    case InOutExponential
    case InCircular
    case OutCircular
    case InOutCircular
    case InBack
    case OutBack
    case InOutBack
    case InElastic
    case OutElastic
    case InOutElastic
    case InBounce
    case OutBounce
    case InOutBounce
    case SpringDecay(velocity: Any?)
    case SpringCustom(velocity: Any?, frequency: CGFloat , ratio: CGFloat)
    
    func parametricProgress(p : CGFloat) -> CGFloat {
        switch self {
        case .Linear:
            return p
        case .LinearSmooth:
            return p * p * (3.0 - 2.0 * p)
        case .LinearSmoother:
            return  p * p * p * (p * (p * 6.0 - 15.0) + 10.0)
        case .InSine:
            return sin((p - 1.0) * CGFloat(M_PI_2)) + 1.0
        case .OutSine:
            return sin(p * CGFloat(M_PI_2))
        case .InOutSine:
            return 0.5 * (1.0 - cos(p * CGFloat(M_PI)))
        case .InQuadratic:
            return p * p
        case .OutQuadratic:
            return -(p * (p - 2))
        case .InOutQuadratic:
            if p < 0.5 {
                return 2.0 * p * p
            } else {
                return (-2.0 * p * p) + (4.0 * p) - 1.0
            }
        case .InCubic:
            return p * p * p
        case .OutCubic:
            let f : CGFloat = (p - 1)
            return f * f * f + 1
        case .InOutCubic:
            if p < 0.5 {
                return 4 * p * p * p
            } else {
                let f : CGFloat = ((2 * p) - 2)
                return 0.5 * f * f * f + 1
            }
        case .InQuartic:
            return p * p * p * p
        case .OutQuartic:
            let f : CGFloat = (p - 1.0)
            return f * f * f * (1 - p) + 1
        case .InOutQuartic:
            if (p < 0.5) {
                return 8 * p * p * p * p
            } else {
                let f : CGFloat = (p - 1)
                return -8 * f * f * f * f + 1
            }
        case .InQuintic:
            return p * p * p * p * p
        case .OutQuintic:
            let f : CGFloat = (p - 1.0)
            return f * f * f * f * f + 1
        case .InOutQuintic:
            if p < 0.5 {
                return 16 * p * p * p * p * p
            } else {
                let f : CGFloat = ((2 * p) - 2)
                return  0.5 * f * f * f * f * f + 1
            }
        case .InExponential:
            return p == 0.0 ? p : pow(2, 10 * (p - 1))
        case .OutExponential:
            return (p == 1.0) ? p : 1 - pow(2, -10 * p)
        case .InOutExponential:
            if p == 0.0 || p == 1.0 { return p }
            
            if p < 0.5 {
                return 0.5 * pow(2, (20 * p) - 10)
            } else  {
                return -0.5 * pow(2, (-20 * p) + 10) + 1
            }
        case .InCircular:
            return 1 - sqrt(1 - (p * p))
        case .OutCircular:
            return sqrt((2 - p) * p)
        case .InOutCircular:
            if p < 0.5 {
                return 0.5 * (1 - sqrt(1 - 4 * (p * p)))
            } else {
                return 0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1)
            }
        case .InBack:
            return p * p * p - p * sin(p * CGFloat(M_PI))
        case .OutBack:
            let f : CGFloat = (1.0 - p)
            return 1 - (f * f * f - f * sin(f * CGFloat(M_PI)))
        case .InOutBack:
            if p < 0.5  {
                let f : CGFloat = 2 * p
                return 0.5 * (f * f * f - f * sin(f * CGFloat(M_PI)))
            } else {
                let f : CGFloat = (1 - (2*p - 1))
                let calculated = (f * f * f - f * sin(f * CGFloat(M_PI)))
                return 0.5 * (1 - calculated) + 0.5
            }
        case .InElastic:
            return sin(13 * CGFloat(M_PI_2) * p) * pow(2, 10 * (p - 1))
        case .OutElastic:
            return sin(-13 * CGFloat(M_PI_2) * (p + 1)) * pow(2, -10 * p) + 1
        case .InOutElastic:
            if p < 0.5  {
                return 0.5 * sin(13 * CGFloat(M_PI_2) * (2 * p)) * pow(2, 10 * ((2 * p) - 1))
            } else {
                return 0.5 * (sin(-13 * CGFloat(M_PI_2) * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) + 2)
            }
            
        case .InBounce:
            return 1.0 - FAEasing.OutBounce.parametricProgress(1.0 - p)
        case .OutBounce:
            if(p < 4.0/11.0) {
                return (121.0 * p * p)/16.0;
            } else if(p < 8.0/11.0) {
                return (363.0/40.0 * p * p) - (99.0/10.0 * p) + 17.0/5.0;
            } else if(p < 9.0/10.0) {
                return (4356.0/361.0 * p * p) - (35442.0/1805.0 * p) + 16061.0/1805.0;
            }else {
                return (54.0/5.0 * p * p) - (513.0/25.0 * p) + 268.0/25.0;
            }
        case .InOutBounce:
            if(p < 0.5) {
                return 0.5 * FAEasing.InBounce.parametricProgress(p * 2.0);
            } else{
                return 0.5 * FAEasing.OutBounce.parametricProgress(p * 2.0 - 1.0) + 0.5;
            }
        case SpringCustom(_, _ , _):
            print("Assigned SpringCustom")
            return p
        case .SpringDecay(_):
            print("SpringDecay")
            return p
        }
    }
}

public func ==(lhs : FAEasing, rhs : FAEasing) -> Bool {
    switch lhs {
    case .Linear:
          switch rhs { case .Linear: return true default: return false }
    case .LinearSmooth:
          switch rhs { case .LinearSmooth: return true default: return false }
    case .LinearSmoother:
          switch rhs { case .LinearSmoother: return true default: return false }
    case .InSine:
          switch rhs { case .InSine: return true default: return false }
    case .OutSine:
          switch rhs { case .OutSine: return true default: return false }
    case .InOutSine:
          switch rhs { case .InOutSine: return true default: return false }
    case .InQuadratic:
          switch rhs { case .InQuadratic: return true default: return false }
    case .OutQuadratic:
          switch rhs { case .OutQuadratic: return true default: return false }
    case .InOutQuadratic:
          switch rhs { case .InOutQuadratic: return true default: return false }
    case .InCubic:
          switch rhs { case .InCubic: return true default: return false }
    case .OutCubic:
          switch rhs { case .OutCubic: return true default: return false }
    case .InOutCubic:
          switch rhs { case .InOutCubic: return true default: return false }
    case .InQuartic:
          switch rhs { case .InQuartic: return true default: return false }
    case .OutQuartic:
          switch rhs { case .OutQuartic: return true default: return false }
    case .InOutQuartic:
          switch rhs { case .InOutQuartic: return true default: return false }
    case .InQuintic:
          switch rhs { case .InQuintic: return true default: return false }
    case .OutQuintic:
          switch rhs { case .OutQuintic: return true default: return false }
    case .InOutQuintic:
          switch rhs { case .InOutQuintic: return true default: return false }
    case .InExponential:
          switch rhs { case .InExponential: return true default: return false }
    case .OutExponential:
          switch rhs { case .OutExponential: return true default: return false }
    case .InOutExponential:
          switch rhs { case .InOutExponential: return true default: return false }
    case .InCircular:
          switch rhs { case .InCircular: return true default: return false }
    case .OutCircular:
          switch rhs { case .OutCircular: return true default: return false }
    case .InOutCircular:
          switch rhs { case .InOutCircular: return true default: return false }
    case .InBack:
          switch rhs { case .InBack: return true default: return false }
    case .OutBack:
          switch rhs { case .OutBack: return true default: return false }
    case .InOutBack: 
          switch rhs { case .InOutBack: return true default: return false }
    case .InElastic: 
          switch rhs { case .InElastic: return true default: return false }
    case .OutElastic: 
          switch rhs { case .OutElastic: return true default: return false }
    case .InOutElastic: 
          switch rhs { case .InOutElastic: return true default: return false }
    case .InBounce: 
          switch rhs { case .InBounce: return true default: return false }
    case .OutBounce:
          switch rhs { case .OutBounce: return true default: return false }
    case .InOutBounce: 
          switch rhs { case .InOutBounce: return true default: return false }
    case .SpringCustom(_, _ , _):
        switch rhs { case .SpringCustom(_, _ , _): return true default: return false }
    case .SpringDecay(_):
          switch rhs { case .SpringDecay(_): return true default: return false }
    }
}
