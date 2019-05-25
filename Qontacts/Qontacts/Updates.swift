//
//  Updates.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import DeepDiff

class Updates {
    
    static let shared = Updates()
    
    let list = BehaviorRelay<[Update]>(value: [
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
            Update(
                contactId: UUID().uuidString,
                title: "Steve Erwin",
                message: "You scanned yesterday at 12:45pm",
                subtitle: "HOST at ANIMAL PLANET",
                action: "Tap to share your contact info"),
        ])
    
}

struct Update: Codable, DiffAware, Hashable, Equatable {
    
    let contactId: String
    let title: String
    let message: String
    let subtitle: String?
    let action: String?
    
    var diffId: Int {
        return hashValue
    }
    
    static func compareContent(_ a: Update, _ b: Update) -> Bool {
        return a == b
    }
}
