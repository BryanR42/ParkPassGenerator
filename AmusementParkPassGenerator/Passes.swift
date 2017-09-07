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
struct Discount {
    var foodDiscount: [PassType: Double] = [.vipGuest: 0.10, .hourlyFoodService: 0.15, .hourlyMaintenance: 0.15, .hourlyRideService: 0.15, .manager: 0.25]
    var merchandiseDiscount: [PassType: Double] = [.vipGuest: 0.20, .hourlyFoodService: 0.25, .hourlyMaintenance: 0.25, .hourlyRideService: 0.25, .manager: 0.25]
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
    let passType: PassType
    weak var passHolder: PassHolder?

    init(type: PassType, passHolder: PassHolder?) {
        self.passType = type
        if let accesses = permissions.list[type] {
        self.accesses = accesses
        } else {
            self.accesses = []
        }
        if let passHolder = passHolder {
            self.passHolder = passHolder
        } else {
            self.passHolder = nil
        }
    }
    func swipeTest(for group: AccessGroups)  {
        var allowedAreas: AreaGroup = []
        var deniedAreas: AreaGroup = []
        
        switch group {
        case .rideAreas:
            for area in rideAreas {
                if testAccess(to: area, with: self) {
                    allowedAreas.append(area)
                    print("Access Granted: \(area)")
                } else {
                    deniedAreas.append(area)
                    print("Access Denied: \(area)")
                }
            }
            
        case .employeeAreas:
            for area in employeeAreas {
                if testAccess(to: area, with: self) {
                    allowedAreas.append(area)
                    print("Access Granted: \(area)")
                } else {
                    deniedAreas.append(area)
                    print("Access Denied: \(area)")
                }
            }
            for area in rideAreas {
                if testAccess(to: area, with: self) {
                    allowedAreas.append(area)
                    print("Access Granted: \(area)")
                } else {
                    deniedAreas.append(area)
                    print("Access Denied: \(area)")
                }
            }
        case .discounts:
        let discounts = Discount()
        if testAccess(to: .foodDiscount, with: self) {
            if let foodRate = discounts.foodDiscount[self.passType] {
                print("Food discount: \(Int(foodRate * 100))%")
            }
        }
        if testAccess(to: .merchandiseDiscount, with: self) {
            if let merchRate = discounts.merchandiseDiscount[self.passType] {
                print("Merchandise discount: \(Int(merchRate * 100))%")
            }
            }
        }
        
    }

    
}








