//
//  LikedUsers.swift
//  PortfolioApp
//
//  Created by Michael Wang on 3/14/22.
//

import Foundation

struct LikedUsers {
    var name: String?
    @LikedUserPropWrapper var imageUrl: String?
}

@propertyWrapper
struct LikedUserPropWrapper {
    private var _value: String?
    var wrappedValue: String? {
        get { _value }
        set {
            guard let newValue = newValue else {
                _value = nil
                return
            }
            _value = (newValue == "null" || newValue.isEmpty) ? nil : newValue
        }
    }
    
    init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
}
