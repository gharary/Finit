//
//  CircleView.swift
//  testCircle
//
//  Created by Mohammad Gharari on 2/4/18.
//  Copyright © 2018 Mohammad Gharari. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        //Get the graphics context
        let context = UIGraphicsGetCurrentContext()
        
        //Set the circle outline-width
        context!.setLineWidth(5.0)
        
        //Set the circle outline-Colour
        UIColor.red.set()
        
        //create circle
        context?.addArc(center: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 10) / 2, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)

        // Draw
        context!.strokePath();

        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
