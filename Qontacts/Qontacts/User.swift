//
//  User.swift
//  Qontacts
//
//  Created by Sammy Yousif on 5/23/19.
//  Copyright © 2019 Sammy Yousif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class User {
    static let shared = User()
    
    let photo = BehaviorRelay<UIImage?>(value: nil)
    
    let sections: [Section] = [
        Section(title: "Personal", fields: [
                Field(id: "name"),
                Field(id: "birthday", inputMode: .birthday, placeholder: "MM/DD"),
                Field(id: "number", inputMode: .phone),
                Field(id: "email", inputMode: .email),
                Field(id: "website", inputMode: .site)
            ]),
        Section(title: "Work", fields: [
                Field(id: "workplace", title: "Place"),
                Field(id: "jobTitle", title: "Title"),
                Field(id: "number", inputMode: .phone),
                Field(id: "email", inputMode: .email),
                Field(id: "website", inputMode: .site)
            ]),
        Section(title: "Education", fields: [
                Field(id: "school"),
                Field(id: "major"),
                Field(id: "email", inputMode: .email)
            ]),
        Section(title: "Social Media", fields: [
                Field(id: "instagram", inputMode: .handle),
                Field(id: "twitter", inputMode: .handle),
                Field(id: "snapchat", inputMode: .handle),
                Field(id: "youtube", title: "YouTube"),
                Field(id: "soundcloud")
            ]),
    ]
    
//    var fields: [Field] {
//        return sections.reduce([Field]()) { fields, section -> [Field] in
//            var fields = fields
//            fields += section.fields
//            return fields
//        }
//    }
    
    struct Field {
        let id: String
        let relay = BehaviorRelay<String?>(value: "")
        let title: String
        let inputMode: ProfileTextField.Mode
        let placeholder: String?
        
        init(id: String, title: String? = nil, inputMode: ProfileTextField.Mode = .text, placeholder: String? = nil) {
            self.id = id
            self.title = title ?? id.uppercasedFirst()
            self.inputMode = inputMode
            self.placeholder = placeholder
        }
    }
    
    struct Section {
        let title: String
        let fields: [Field]
    }
}

extension String {
    func uppercasedFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func uppercasedFirst() {
        self = self.uppercasedFirst()
    }
}
