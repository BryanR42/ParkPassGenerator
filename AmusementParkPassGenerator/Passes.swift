//
//  PassTypes.swift
//  AmusementParkPassGenerator
//
//  Created by Bryan Richardson on 9/3/17.
//  Copyright © 2017 Bryan Richardson. All rights reserved.
//

import Foundation


enum PassType {
    case classicGuest
    case vipGuest
    case freeChildGuest
    case hourlyFoodService
    case hourlyRideService
    case hourlyMaintenance
    case manager
}
enum AccessType: String {
    case amusementAreas
    case allRides
    case allRideSkipLines
    case kitchenAreas
    case rideControlAreas
    case maintenanceAreas
    case officeAreas
    case foodDiscount
    case merchandiseDiscount
}
enum PassError: Error {
    case childOverFive(Int)
    case insufficientPersonalInfo(String)
    case noPermissions
    case passHolderNotFound
    case issuePassFailed
}

struct PassCardPermissions {
    let list: [PassType: [AccessType]] = [
        .classicGuest: [.amusementAreas, .allRides],
        .vipGuest: [.amusementAreas, .allRides, .allRideSkipLines, .foodDiscount, .merchandiseDiscount],
        .freeChildGuest: [.amusementAreas, .allRides],
        .hourlyFoodService: [.amusementAreas, .allRides, .kitchenAreas, .foodDiscount, .merchandiseDiscount],
        .hourlyRideService: [.amusementAreas, .allRides, .rideControlAreas, .foodDiscount, .merchandiseDiscount],
        .hourlyMaintenance: [.amusementAreas, .allRides, .kitchenAreas, .rideControlAreas, .maintenanceAreas, .foodDiscount, .merchandiseDiscount],
        .manager: [.amusementAreas, .allRides, .kitchenAreas, .rideControlAreas, .maintenanceAreas, .officeAreas, .foodDiscount, .merchandiseDiscount]]
}

let permissions = PassCardPermissions()

class PassCard {
    let accesses: [AccessType]
    weak var passHolder: PassHolder?

    init(accesses: [AccessType], passHolder: PassHolder?) {
        self.accesses = accesses
        if let passHolder = passHolder {
            self.passHolder = passHolder
        } else {
            self.passHolder = nil
        }
    }
    
}








