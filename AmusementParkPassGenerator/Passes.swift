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
enum accessType {
    case amusementAreas
    case allRides
    case allRideSkipLines
    case kitchenAreas
    case rideControlAreas
    case maintenanceAreas
    case officeAreas
    case foodDiscount(Double)
    case merchandiseDiscount(Double)
}
enum PassError: Error {
    case childOverFive
    case insufficientPersonalInfo
    case noPermissions
    case passNotFound
}

struct PassCardPermissions {
    let list: [PassType: [accessType]] = [
        .classicGuest: [.amusementAreas, .allRides],
        .vipGuest: [.amusementAreas, .allRides, .allRideSkipLines, .foodDiscount(0.10), .merchandiseDiscount(0.20)],
        .freeChildGuest: [.amusementAreas, .allRides],
        .hourlyFoodService: [.amusementAreas, .allRides, .kitchenAreas, .foodDiscount(0.15), .merchandiseDiscount(0.25)],
        .hourlyRideService: [.amusementAreas, .allRides, .rideControlAreas, .foodDiscount(0.15), .merchandiseDiscount(0.25)],
        .hourlyMaintenance: [.amusementAreas, .allRides, .kitchenAreas, .rideControlAreas, .maintenanceAreas, .foodDiscount(0.15), .merchandiseDiscount(0.25)],
        .manager: [.amusementAreas, .allRides, .kitchenAreas, .rideControlAreas, .maintenanceAreas, .officeAreas, .foodDiscount(0.25), .merchandiseDiscount(0.25)]]
}

let permissions = PassCardPermissions()

class PassCard {
    let accesses: [accessType]
    weak var passHolder: PassHolder?

    init(accesses: [accessType], passHolder: PassHolder?) {
        self.accesses = accesses
        if let passHolder = passHolder {
            self.passHolder = passHolder
        } else {
            self.passHolder = nil
        }
    }
}

func IssuePass(type: PassType, to passHolder: PassHolder?) throws -> PassCard {
    guard let passAccess = permissions.list[type] else { throw PassError.noPermissions }
    let passCard = PassCard(accesses: passAccess, passHolder: passHolder)
    switch type {
    case .freeChildGuest: if passHolder?.age != nil && passHolder!.age! < 5 {
        return passCard
    } else {
        throw PassError.childOverFive
        }
    case .hourlyFoodService, .hourlyMaintenance, .hourlyRideService, .manager: if passHolder?.firstName != nil && passHolder?.lastName != nil && passHolder?.address != nil {
        return passCard
    } else {
        throw PassError.insufficientPersonalInfo
        }
    default: return passCard
    }
}








