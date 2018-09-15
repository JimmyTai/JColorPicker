//
//  ColorSquarePicker.swift
//  ColorPicker
//
//  Created by Jimmy Tai on 2018/8/21.
//  Copyright © 2018年 JimmyTai. All rights reserved.
//

import UIKit
import Foundation

protocol ColorPickerDelegate {
    func colorSelected(selectedColor color: UIColor)
}

@IBDesignable
open class ColorPicker: UIControl {
    
    private let contentInsetX: CGFloat = 0
    private let contentInsetY: CGFloat = 0
    
    private let indicatorSizeInactive: CGFloat = 45
    private let indicatorSizeActive: CGFloat = 55
    
    var delegate: ColorPickerDelegate?
    
    private lazy var colorSquareView: ColorSquareView = {
        return ColorSquareView()
    }()
    
    private lazy var aplphaSquareView: ColorSquareView = {
        return ColorSquareView()
    }()
    
    open lazy var indicator: ColorIndicatorView = {
        
        let size = CGSize(width: self.indicatorSizeInactive, height: self.indicatorSizeInactive)
        let indicatorRect = CGRect(origin: .zero, size: size)
        
        return ColorIndicatorView(frame: indicatorRect)
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    public func setColor(red: Int, green: Int, blue: Int) {
        let rgb = RGB(r: CGFloat(red) / 255.0, g: CGFloat(green) / 255, b: CGFloat(blue) / 255)
        print("setColor (r, g, b) = (\(rgb.r), \(rgb.g), \(rgb.b))")
        let hsv = rgb.toHSV(preserveHS: true)
        print("set color hue: \(hsv.h * 360)")
        
        let x = hsv.h * self.bounds.width
        var saturation = hsv.s
        if saturation > 1 {
            saturation = 1
        } else if saturation < 0.2 {
            saturation = 0.2
        }
        let y = self.bounds.height - (saturation - 0.2) / 0.8 * self.bounds.height
        
        indicator.center = CGPoint(x: x, y: y)
        setIndicatorColor()
    }
    
    public func getColor() -> UIColor {
        return indicator.color
    }
    
    private func setIndicatorColor() {
        let color = colorSquareView.getPixelColorAtPoint(point: CGPoint(x: indicator.center.x, y: 5))
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let sat = ((self.bounds.height - indicator.center.y) / self.bounds.height * 0.8 + 0.2)
        let newColor = UIColor(hue: hue, saturation: sat, brightness: brightness, alpha: alpha)
        indicator.color = newColor
    }
    
    // MARK - Drawing
    
    open override func layoutSubviews() {
        if colorSquareView.superview == nil {
            print("colorSquareView width: \(bounds.width), height: \(bounds.height)")
            let image = UIImage.gradientImageWithBounds(
                bounds: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
                colors: [
                    getColor(hexString: "#E6312E").cgColor,
                    getColor(hexString: "#E6842E").cgColor, getColor(hexString: "#E6D72E").cgColor,
                    getColor(hexString: "#98E62E").cgColor, getColor(hexString: "#2EE62F").cgColor,
                    getColor(hexString: "#2EE67C").cgColor, getColor(hexString: "#2ED5E6").cgColor,
                    getColor(hexString: "#2E79E6").cgColor, getColor(hexString: "#302EE6").cgColor,
                    getColor(hexString: "#7D2EE6").cgColor, getColor(hexString: "#E62EE3").cgColor,
                    getColor(hexString: "#E62EB5").cgColor,
                    getColor(hexString: "#E6312E").cgColor
                ],
                startPoint: CGPoint(x: 0, y: 0.5),
                endPoint: CGPoint(x: 1, y: 0.5))
            colorSquareView.image = image
            colorSquareView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(colorSquareView)
            
            colorSquareView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: contentInsetX).isActive = true
            colorSquareView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -contentInsetX).isActive = true
            colorSquareView.topAnchor.constraint(equalTo: self.topAnchor, constant: contentInsetY).isActive = true
            colorSquareView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -contentInsetY).isActive = true
        }
        
        if aplphaSquareView.superview == nil {
            let alphaImage = UIImage.gradientImageWithBounds(
                bounds: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height),
                colors: [getColor(hexString: "#20FFFFFF").cgColor, getColor(hexString: "#C0FFFFFF").cgColor],
                startPoint: CGPoint(x: 0.5, y: 0),
                endPoint: CGPoint(x: 0.5, y: 1))
            aplphaSquareView.image = alphaImage
            aplphaSquareView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(aplphaSquareView)
            
            aplphaSquareView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: contentInsetX).isActive = true
            aplphaSquareView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -contentInsetX).isActive = true
            aplphaSquareView.topAnchor.constraint(equalTo: self.topAnchor, constant: contentInsetY).isActive = true
            aplphaSquareView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -contentInsetY).isActive = true
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
            d.colorSelected(selectedColor: indicator.color)
        }
    }
    
    open override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        shrinkIndicator()
        if let d = delegate {
            d.colorSelected(selectedColor: indicator.color)
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
