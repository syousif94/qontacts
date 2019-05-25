//
//  ScanButton.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import PinLayout

class ScanButton: UIView {
    let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "ScanBackground"))
    let button = FadingButton()
    let icon = UIImageView(image: #imageLiteral(resourceName: "ScanQR"))
    
    init() {
        super.init(frame: .zero)
        
        frame.size = backgroundImage.image!.size
        
        addSubview(backgroundImage)
        
        addSubview(button)
        
        button.addSubview(icon)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImage.pin.all()
        
        button.pin.all()
        
        icon.pin.center()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
