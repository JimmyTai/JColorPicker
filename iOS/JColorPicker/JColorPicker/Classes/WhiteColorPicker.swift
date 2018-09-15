//
//  ColorSquarePicker.swift
//  ColorPicker
//
//  Created by Jimmy Tai on 2018/8/21.
//  Copyright © 2018年 JimmyTai. All rights reserved.
//

import Foundation
import UIKit

protocol WhiteColorPickerDelegate {
    func colorSelected(whiteSelectedColor color: UIColor)
}

@IBDesignable
open class WhiteColorPicker: UIControl {

    private let contentInsetX: CGFloat = 0
    private let contentInsetY: CGFloat = 0
    
    private let indicatorSizeInactive: CGFloat = 45
    private let indicatorSizeActive: CGFloat = 55
    
    var delegate: WhiteColorPickerDelegate?
    
    private lazy var colorSquareView: ColorSquareView = {
        return ColorSquareView()
    }()
    
    open lazy var indicator: ColorIndicatorView = {
        
        let size = CGSize(width: self.indicatorSizeInactive, height: self.indicatorSizeInactive)
        let indicatorRect = CGRect(origin: .zero, size: size)
        
        return ColorIndicatorView(frame: indicatorRect)
    }()
    
    public func setColor(red: Int, green: Int, blue: Int) {
        let rgb = RGB(r: CGFloat(red) / 255.0, g: CGFloat(green) / 255, b: CGFloat(blue) / 255)
        print("setColor (r, g, b) = (\(rgb.r), \(rgb.g), \(rgb.b))")
        let hsv = rgb.toHSV(preserveHS: true)
        print("set color hue: \(hsv.h * 360)")
        var hue = CGFloat(hsv.h) * 360
        if hue > 196 {
            hue = 196
        } else if hue < 44 {
            hue = 44
        }
        var x: CGFloat = 0.0, y: CGFloat = 0.0;
        if hue <= 60 {
            x = abs(CGFloat(blue) - 150) / 99 * (self.bounds.width / 2)
            y = self.bounds.height - (self.bounds.height / self.bounds.width * x)
        } else {
            x = self.bounds.width / 2 + abs(CGFloat(red) - 249) / 56 * (self.bounds.width / 2)
            y = self.bounds.height - (self.bounds.height / self.bounds.width * x)
        }
        print("set color x: \(x), y: \(y)")
        indicator.center = CGPoint(x: x, y: y)
        setIndicatorColor()
    }
    
    public func getColor() -> UIColor {
        return indicator.color
    }
    
    private func setIndicatorColor() {
        let color = colorSquareView.getPixelColorAtPoint(point: indicator.center)
        indicator.color = color
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    open override func layoutSubviews() {
        if colorSquareView.superview == nil {
            print("colorSquareView width: \(bounds.width), height: \(bounds.height)")
            let image = UIImage.gradientImageWithBounds(
                bounds: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
                colors: [
                    getColor(hexString: "#C1EAF9").cgColor, getColor(hexString: "#F9F9F3").cgColor,
                    getColor(hexString: "#EED796").cgColor
                ],
                startPoint: CGPoint(x: 1, y: 0),
                endPoint: CGPoint(x: 0, y: 1))
            colorSquareView.image = image
            colorSquareView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(colorSquareView)
            
            colorSquareView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: contentInsetX).isActive = true
            colorSquareView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -contentInsetX).isActive = true
            colorSquareView.topAnchor.constraint(equalTo: self.topAnchor, constant: contentInsetY).isActive = true
            colorSquareView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -contentInsetY).isActive = true
        }
        
        
        if indicator.superview == nil {
            self.addSubview(indicator)
        }
        
        indicator.center = self.center
        setIndicatorColor()
    }
    
    
    // MARK: - Tracking
    
    private func trackIndicator(with touch: UITouch) {
        
        var position = touch.location(in: self)
        if position.x > self.bounds.width - 2 {
            position.x = self.bounds.width - 2
        } else if position.x < 2 {
            position.x = 2
        }
        if position.y > self.bounds.height - 2 {
            position.y = self.bounds.height - 2
        } else if position.y < 2 {
            position.y = 2
        }
        
        print("colorSquareView width: \(colorSquareView.bounds.width), height: \(colorSquareView.bounds.height)")
        print("touch x: \(touch.location(in: self).x), y: \(touch.location(in: self).y)")
        
        indicator.center = position
        setIndicatorColor()
    }
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.trackIndicator(with: touch)
        growIndicator()
        return true
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.trackIndicator(with: touch)
        return true
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        shrinkIndicator()
        if let d = delegate {
            d.colorSelected(whiteSelectedColor: indicator.color)
        }
    }
    
    open override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        shrinkIndicator()
        if let d = delegate {
            d.colorSelected(whiteSelectedColor: indicator.color)
        }
    }
    
    private func changeIndicatorSize(to size: CGFloat) {
        let center = self.indicator.center
        
        let size = CGSize(width: size, height: size)
        let indicatorRect = CGRect(origin: .zero, size: size)
        
        self.indicator.frame = indicatorRect
        self.indicator.center = center
    }
    
    private func growIndicator() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [.curveEaseIn], animations: {
            self.changeIndicatorSize(to: self.indicatorSizeActive)
        }) { (finished) in
        }
    }
    
    private func shrinkIndicator() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [.curveEaseOut], animations: {
            self.changeIndicatorSize(to: self.indicatorSizeInactive)
            self.indicator.setNeedsDisplay()
            
        }) { (finished) in
            self.indicator.setNeedsDisplay()
        }
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

