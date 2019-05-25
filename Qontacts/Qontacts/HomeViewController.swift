//
//  HomeViewController.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import Then

class HomeViewController: UIViewController {
    
    let scanButton = ScanButton()
    
    let qrButtons = ["Social", "Work", "Both", "Custom"].map {
        QRButton(text: $0)
    }
    
    let qrView = UIView().then {
        $0.backgroundColor = UIColor("#F2f2f2")
        $0.layer.cornerRadius = 15
    }
    
    let profileImageView = UIImageView().then {
        $0.backgroundColor = UIColor("#F2f2f2")
        $0.frame.size.height = 50
        $0.frame.size.width = $0.frame.size.height
        $0.layer.cornerRadius = $0.frame.size.height / 2
    }
    
    let searchIcon = UIImageView(image: #imageLiteral(resourceName: "Search"))
    
    let updatesViewController = UpdatesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(qrView)
        
        view.addSubview(profileImageView)
        
        view.addSubview(searchIcon)
        
        for button in qrButtons {
            view.addSubview(button)
        }
        
        addChild(updatesViewController)
        view.addSubview(updatesViewController.view)
        updatesViewController.didMove(toParent: self)
        
        view.addSubview(scanButton)
        
        scanButton.button.addTarget(self, action: #selector(onScanTap), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scanButton.pin.bottom(36).right(27)
        
        profileImageView.pin.top(appDelegate.insets.top + 5).left(QRButton.margin)
        
        searchIcon.pin.right(QRButton.margin).vCenter(to: profileImageView.edge.vCenter).marginTop(1)
        
        let tallScreen = UIScreen.main.bounds.height -
            (profileImageView.frame.height +
            UIScreen.main.bounds.width - QRButton.margin * 2 +
                qrButtons[0].frame.height * 2 + QRButton.margin * 3) > 200
        
        if tallScreen {
            
            qrView.pin
                .below(of: profileImageView)
                .marginTop(QRButton.margin)
                .horizontally(QRButton.margin)
                .aspectRatio(1)
            
            for (index, button) in qrButtons.enumerated() {
                switch index {
                case 0:
                    button.pin.left(QRButton.margin).below(of: qrView).marginTop(QRButton.margin)
                case 1:
                    button.pin.right(QRButton.margin).below(of: qrView).marginTop(QRButton.margin)
                case 2:
                    button.pin.left(QRButton.margin).below(of: qrButtons[0]).marginTop(QRButton.margin)
                case 3:
                    button.pin.right(QRButton.margin).below(of: qrButtons[0]).marginTop(QRButton.margin)
                default:
                    break
                }
            }
        }
        else {
            for (index, button) in qrButtons.reversed().enumerated() {
                switch index {
                case 0:
                    button.pin.right(QRButton.margin).bottom(150)
                case 1:
                    button.pin.left(QRButton.margin).bottom(150)
                case 2:
                    button.pin.right(QRButton.margin).above(of: qrButtons[3]).marginBottom(QRButton.margin)
                case 3:
                    button.pin.left(QRButton.margin).above(of: qrButtons[3]).marginBottom(QRButton.margin)
                default:
                    break
                }
            }
            
            qrView.pin.above(of: qrButtons[0]).below(of: profileImageView).marginVertical(QRButton.margin).maxHeight(UIScreen.main.bounds.width - QRButton.margin * 2).aspectRatio(1).hCenter()
        }
        
        updatesViewController.view.pin.all()
        
        updatesViewController.collectionView.contentInset.top = qrButtons[3].frame.maxY + 10
        updatesViewController.collectionView.contentInset.bottom = UIScreen.main.bounds.height - scanButton.frame.minY + 10
    }
    
    lazy var qrScannerController: QRScannerController = {
        return QRScannerController()
    }()
    
    @objc func onScanTap() {
        qrScannerController.modalPresentationStyle = .overFullScreen
        
        present(qrScannerController, animated: true, completion: nil)
    }
}

extension HomeViewController {
    class QRButton: FadingButton {
        
        static let margin: CGFloat = 10
        
        let icon = UIImageView(image: #imageLiteral(resourceName: "ChoiceQR").withRenderingMode(.alwaysTemplate))
        
        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        }
        
        init(text: String) {
            super.init(frame: .zero)
            
            icon.tintColor = UIColor("#B5B5B5")
            
            label.text = text
            
            label.textColor = UIColor("#A4A4A4")
            
            label.sizeToFit()
            
            addSubview(icon)
            
            addSubview(label)
            
            frame.size.height = icon.image!.size.height + 20
            frame.size.width = (UIScreen.main.bounds.width - QRButton.margin * 3) / 2
            
            backgroundColor = UIColor("#eeeeee")
            layer.cornerRadius = 15
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            icon.pin.vCenter().left(10)
            
            label.pin.sizeToFit().after(of: icon, aligned: .center).marginLeft(10)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
