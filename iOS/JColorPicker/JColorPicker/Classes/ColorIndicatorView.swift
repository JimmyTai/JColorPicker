//
//  ColorIndicatorView.swift
//  ColorPicker
//
//  Created by Jimmy Tai on 2018/8/21.
//  Copyright © 2018年 JimmyTai. All rights reserved.
//

import UIKit

@IBDesignable
open class ColorIndicatorView: UIView {
    
    @IBInspectable
    open var color: UIColor = .black {
        didSet {
            if oldValue != color {
                self.setNeedsDisplay()
            }
            
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isOpaque = false
        self.isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.midX
        
//        // Fill it:
        context.addArc(center: center, radius: radius - 5.0, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: true)
        UIColor.white.setFill()
        context.setShadow(offset: CGSize(width: 0, height: 0), blur: 5.0, color: getColor(hexString: "#e0e0e0").cgColor)
        context.fillPath()
        
        // Fill it:
        context.addArc(center: center, radius: radius - 9.0, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: true)
        self.color.setFill()
        context.fillPath()
    }
    
    private func getColor(hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
