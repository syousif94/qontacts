//
//  ProfileViewController.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import PinLayout
import NotificationCenter

class ProfileViewController: UIViewController {
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = true
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let profilePictureButton = FadingButton().then {
        $0.backgroundColor = UIColor("#eeeeee")
    }
    
    let sections = User.shared.sections.map { section in
        return SectionView(section: section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profilePictureButton)
        
        for section in sections {
            contentView.addSubview(section)
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            //            let startFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            // let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            // let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            else { return }
        
        //        let animationCurveRaw = animationCurveRawNSN.uintValue
        //        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        let willShow = endFrame.origin.y < UIScreen.main.bounds.height
        let endHeight = endFrame.height
        
        if willShow {
            self.scrollView.contentInset.bottom = endHeight + 10
        }
        else {
            self.scrollView.contentInset.bottom = 10
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all()
        
        contentView.pin.topLeft().width(UIScreen.main.bounds.width)
        
        profilePictureButton.pin.horizontally(12%).aspectRatio(1).top(appDelegate.insets.top + 10)
        
        profilePictureButton.layer.cornerRadius = profilePictureButton.frame.height / 2
        
        for (index, section) in sections.enumerated() {
            if index == 0 {
                section.pin.below(of: profilePictureButton).marginTop(40).left()
            }
            else {
                section.pin.below(of: sections[index - 1]).marginTop(20).left()
            }
        }
        
        contentView.pin.height(sections.last!.frame.maxY + appDelegate.insets.bottom)
        
        scrollView.contentSize = contentView.frame.size
    }
}

extension ProfileViewController {
    class SectionView: UIView {
        
        let titleLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        }
        
        let inputs: [ProfileTextField]
        
        init(section: User.Section) {
            
            self.inputs = section.fields.map { field in
                let view = ProfileTextField(dx: 8, relay: field.relay, mode: field.inputMode)
                view.backgroundColor = UIColor("#eeeeee")
                view.layer.cornerRadius = 4
                view.font = ProfileTextField.font
                view.title = field.title
                view.placeholder = field.placeholder
                return view
            }
            
            super.init(frame: .zero)
            
            titleLabel.text = section.title
            
            titleLabel.sizeToFit()
            
            addSubview(titleLabel)
            
            for input in inputs {
                addSubview(input)
            }
            
            frame.size.width = UIScreen.main.bounds.width
            frame.size.height = titleLabel.frame.height + 54 * CGFloat(section.fields.count)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            titleLabel.pin.top().left(15)
            
            for (index, input) in inputs.enumerated() {
                if index == 0 {
                    input.pin.below(of: titleLabel).marginTop(10).horizontally(15).height(44)
                }
                else {
                    input.pin.below(of: inputs[index - 1]).marginTop(10).horizontally(15).height(44)
                }
            }
        }
        
    }
}




