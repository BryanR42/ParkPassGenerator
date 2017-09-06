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
    case guestAreas
    case employeeAreas
    case discounts
}
// let sender = AccessGroups.guestAreas
// let sender = AccessGroups.employeeAreas
// let sender = AccessGroups.discounts

extension AccessType: Equatable {
    static func ==(lhs: AccessType, rhs: AccessType) -> Bool {
        return lhs == rhs
    }
}

typealias AreaGroup = [AccessType]
let guestAreas: AreaGroup = [.allRides, .allRideSkipLines, .amusementAreas]
let employeeAreas: AreaGroup = [.kitchenAreas, .officeAreas, .rideControlAreas, .maintenanceAreas]

func swipeTest(for group: AccessGroups, with pass: PassCard)  {
    var allowedAreas: AreaGroup = []
    var deniedAreas: AreaGroup = []
    
    switch group {
    case .guestAreas:
        for area in guestAreas {
            if testAccess(to: area, with: pass) {
                allowedAreas.append(area)
            } else {
                deniedAreas.append(area)
            }
        }
    case .employeeAreas:
        for area in employeeAreas {
            if testAccess(to: area, with: pass) {
                allowedAreas.append(area)
            } else {
                deniedAreas.append(area)
            }
        }
        for area in guestAreas {
            if testAccess(to: area, with: pass) {
                allowedAreas.append(area)
            } else {
                deniedAreas.append(area)
            }
        }
    case .discounts: break        // uggggh!!!!!
    }
        
    }



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



























