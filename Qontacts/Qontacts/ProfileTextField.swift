//
//  PaddedTextField.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa
import InputMask

class ProfileTextField: UITextField {
    
    static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    enum Mode {
        case text
        case phone
        case email
        case site
        case handle
        case birthday
    }
    
    let mode: Mode
    
    let titleView = UIView()
    
    let titleLabel = UILabel()
    
    let dx: CGFloat
    
    let bag = DisposeBag()
    
    var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = title
                titleLabel.sizeToFit()
                titleView.frame.size.height = titleLabel.frame.height
                leftView = titleView
                leftViewMode = .always
            }
            else {
                leftView = nil
                leftViewMode = .never
            }
            
            setNeedsLayout()
        }
    }
    
    override var font: UIFont! {
        didSet {
            titleLabel.font = font
            setNeedsLayout()
        }
    }
    
    init(dx: CGFloat, relay: BehaviorRelay<String?>, mode: Mode = .text) {
        self.dx = dx
        self.mode = mode
        
        super.init(frame: .zero)
        
        titleView.addSubview(titleLabel)
        
        titleView.frame.size.width = 100
        
        titleView.isUserInteractionEnabled = false
        
        (rx.text <-> relay).disposed(by: bag)
        
        switch mode {
        case .phone, .birthday:
            delegate = maskDelegate
            keyboardType = .numberPad
            returnKeyType = .done
        case .text:
            autocapitalizationType = .words
        case .email:
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no
        case .site:
            keyboardType = .URL
            autocapitalizationType = .none
            autocorrectionType = .no
        case .handle:
            keyboardType = .twitter
            autocapitalizationType = .none
            autocorrectionType = .no
        }
    }
    
    lazy var maskDelegate: MaskedTextFieldDelegate = {
        
        var format = "([000]) [000]-[0000]"
        
        if mode == .birthday {
            format = "[00]{/}[00]"
        }
        
        return MaskedTextFieldDelegate(
            primaryFormat: format,
            autocomplete: true,
            autocompleteOnFocus: false,
            rightToLeft: false,
            affineFormats: [],
            affinityCalculationStrategy: .prefix,
            customNotations: [],
            onMaskedTextChangedCallback: { (input, text, complete) in })
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin.vCenter().left(dx)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let vInset = (frame.height - font.lineHeight) / 2
        let leftInset = title == nil ? dx : titleView.frame.width
        return bounds.inset(by: UIEdgeInsets(top: vInset, left: leftInset, bottom: vInset, right: 0))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let vInset = (frame.height - font.lineHeight) / 2
        let leftInset = title == nil ? dx : titleView.frame.width
        return bounds.inset(by: UIEdgeInsets(top: vInset, left: leftInset, bottom: vInset, right: 0))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let vInset = (frame.height - font.lineHeight) / 2
        let leftInset = title == nil ? dx : titleView.frame.width
        return bounds.inset(by: UIEdgeInsets(top: vInset, left: leftInset, bottom: vInset, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
