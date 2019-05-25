//
//  Views.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit

class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

class FadingButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            self.fade()
        }
    }
    
    func fade() {
        let opacity: Float = self.isHighlighted ? 0.2 : 1
        UIView.animate(withDuration: 0.2) {
            for view in self.subviews {
                view.layer.opacity = opacity
            }
        }
    }
}

extension UIScrollView {
    var maxOffset: CGFloat {
        return floor(contentSize.height - frame.height)
    }
    
    var maxXOffset: CGFloat {
        return floor(contentSize.width - frame.width)
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= maxOffset
    }
    
    var isAtTop: Bool {
        return contentOffset.y == 0 - contentInset.top
    }
    
    var isAtStart: Bool {
        return contentOffset.x == 0 - contentInset.top
    }
    
    var isAtEnd: Bool {
        return contentOffset.x >= maxXOffset
    }
    
    func scrollToBottom() {
        setContentOffset(CGPoint(x: 0, y: maxOffset), animated: true)
    }
}
