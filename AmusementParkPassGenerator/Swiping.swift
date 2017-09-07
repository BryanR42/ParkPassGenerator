//
//  Swiping.swift
//  AmusementParkPassGenerator
//
//  Created by Bryan Richardson on 9/5/17.
//  Copyright © 2017 Bryan Richardson. All rights reserved.
//

import Foundation


// Once UI is complete, the test method will be indicated by the sender button.

// sender will be held by a variable for the purpose of this test

enum AccessGroups {
    case rideAreas
    case employeeAreas
    case discounts
}
// let sender = AccessGroups.guestAreas
// let sender = AccessGroups.employeeAreas
// let sender = AccessGroups.discounts

extension AccessType: Equatable {
    static func ==(lhs: AccessType, rhs: AccessType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

typealias AreaGroup = [AccessType]
let rideAreas: AreaGroup = [.allRides, .allRideSkipLines, .amusementAreas]
let employeeAreas: AreaGroup = [.kitchenAreas, .officeAreas, .rideControlAreas, .maintenanceAreas]



// I didn't like the contains method, it seems unnecessarily complex and if I understand it right, it does the same thing by comparing each element.
func testAccess(to type: AccessType, with pass: PassCard) -> Bool {
    let passAllowances: [AccessType] = pass.accesses
    
    for eachAccess in passAllowances {
        if eachAccess == type {
            return true
        }
    }
    return false
}



























