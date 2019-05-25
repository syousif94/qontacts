//
//  UpdatesViewController.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import RxSwift
import DeepDiff
import PinLayout

class UpdatesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: CollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let view = CollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(Cell.self, forCellWithReuseIdentifier: Cell.id)
        view.backgroundColor = .clear
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    override func loadView() {
        self.view = PassthroughView()
    }
    
    var items = [Update]()
    
    let bag = DisposeBag()
    
    private let cellTemplate = Cell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        Updates.shared.list
            .throttle(0.25, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [unowned self] list in
            
                let changes = diff(old: self.items, new: list)
                
                if changes.count > 0 {
                    DispatchQueue.main.async {
                        self.collectionView.reload(changes: changes, updateData: {
                            self.items = list
                        })
                    }
                }
                
        }).disposed(by: bag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.id, for: indexPath) as! Cell
        view.data = items[indexPath.item]
        return view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.pin.all()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.configure(data: items[indexPath.row])
        return cellTemplate.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
    }
    
}

extension UpdatesViewController {
    class Cell: UICollectionViewCell {
        
        static let id = "cell"
        
        var data: Update? {
            didSet {
                configure(data: data)
            }
        }
        
        func configure(data: Update?) {
            
            guard let data = data else { return }
            
            titleLabel.text = data.title
            
            messageLabel.text = data.message
            
            actionLabel.text = data.action
            
            setNeedsLayout()
        }
        
        let backingView = FadingButton().then {
            $0.backgroundColor = .white
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor("#F2F2F2").cgColor
            $0.layer.cornerRadius = 15
            $0.layer.shadowColor = UIColor("#DFDFDF").cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = CGSize(width: 0, height: 1)
            $0.layer.shadowRadius = 4
        }
        
        let imageView = UIImageView().then {
            $0.backgroundColor = UIColor("#cccccc")
            $0.layer.cornerRadius = 7
        }
        
        let titleLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        
        let messageLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
        
        let actionLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.textColor = UIColor("#757575")
            $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(backingView)
            
            backingView.addSubview(imageView)
            
            backingView.addSubview(titleLabel)
            
            backingView.addSubview(messageLabel)
            
            backingView.addSubview(actionLabel)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            layout()
        }
        
        private func layout() {
            backingView.pin.horizontally(10)
            imageView.pin.left(10).top(10).height(60).width(60)
            titleLabel.pin.after(of: imageView, aligned: .top).marginLeft(6).right(6).sizeToFit(.width)
            messageLabel.pin.below(of: titleLabel, aligned: .left).right(6).sizeToFit(.width).marginTop(3)
            actionLabel.pin.below(of: messageLabel, aligned: .left).right(6).sizeToFit(.width).marginTop(8)
            backingView.pin.wrapContent(padding: PEdgeInsets(top: 10, left: 10, bottom: 10, right: 6))
            contentView.pin.height(backingView.frame.maxY)
        }
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            contentView.pin.width(size.width)
            layout()
            let size = contentView.frame.size
            return size
        }
        
    }
    
    class CollectionView: UICollectionView {
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            
            if point.y < 0 { return nil }
            
            return view
        }
    }
}


