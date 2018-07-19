//
//  Dount.swift
//  NoxClock
//
//  Created by Andy_Liu on 2018/7/12.
//  Copyright © 2018年 Nox. All rights reserved.
//

import UIKit

import UIKit

class Dount: UIView {
    
    public var startAngle:CGFloat = 0;
    public var endAngle:CGFloat = 0;
    public var thickness:Int = 13;

    var size = CGSize.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear;
        size = frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.backgroundColor = UIColor.clear;
        size = frame.size
    }
    
    var niceImage: UIImage {
        
        let kThickness = CGFloat(thickness)
        let kLineWidth = CGFloat(0)
        let kShadowWidth = CGFloat(0)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let gc = UIGraphicsGetCurrentContext()!
        gc.addArc(center: CGPoint(x: size.width/2, y: size.height/2),
                  radius: (size.width - kThickness - kLineWidth)/2,
                  startAngle: startAngle°,
                  endAngle: endAngle°,
                  clockwise: true)
        
        gc.setLineWidth(kThickness)
        gc.setLineCap(.butt)
        gc.replacePathWithStrokedPath()
        
        let path = gc.path!
        
        gc.setShadow(
            offset: CGSize(width: 0, height: kShadowWidth/2),
            blur: kShadowWidth/2,
            color: UIColor.gray.cgColor
        )
        
        gc.beginTransparencyLayer(auxiliaryInfo: nil)
        
        gc.saveGState()
        
        let rgb = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(
            colorsSpace: rgb,
            colors: [UIColor.init(hex: "6FD0C1").cgColor,UIColor.init(hex: "A9D98F").cgColor,UIColor.init(hex: "8F95D9").cgColor] as CFArray,
            locations: [CGFloat(0),CGFloat(0.5),CGFloat(1)])!
        
        let bbox = path.boundingBox
        let startP = bbox.origin
        var endP = CGPoint(x: bbox.maxX, y: bbox.maxY);
        if (bbox.size.width > bbox.size.height) {
            endP.y = startP.y
        } else {
            endP.x = startP.x
        }
        
        gc.clip()
        
        gc.drawLinearGradient(gradient, start: startP, end: endP,
                              options: CGGradientDrawingOptions(rawValue: 0))
        
        gc.restoreGState()
        
        gc.addPath(path)
        
        gc.setLineWidth(kLineWidth)
        gc.setLineJoin(.miter)
        UIColor.black.setStroke()
        gc.strokePath()
        
        gc.endTransparencyLayer()
        
        UIColor.clear.setFill()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    override func draw(_ rect: CGRect) {
        niceImage.draw(at:.zero)
    }
    
    public func changeAngle(angle:CGFloat) {
        
        startAngle += angle;
        self.setNeedsDisplay()
    }
}

postfix operator °

protocol IntegerInitializable: ExpressibleByIntegerLiteral {
    init (_: CGFloat)
}

extension CGFloat: IntegerInitializable {
    postfix public static func °(lhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) * .pi / 180
    }
}
