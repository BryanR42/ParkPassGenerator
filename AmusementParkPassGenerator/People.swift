//
//  People.swift
//  AmusementParkPassGenerator
//
//  Created by Bryan Richardson on 9/3/17.
//  Copyright © 2017 Bryan Richardson. All rights reserved.
//

import Foundation

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
}

protocol Person {
    var firstName: String? { get }
    var lastName: String? { get }
    var address: Address? { get }
    var dateOfBirth: Date? { get }
}

struct Address {
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
    var fullAddress: String {
        return "\(streetAddress), \(city), \(state), \(zipCode)"
    }
}

class PassHolder: Person {
    let firstName: String?
    let lastName: String?
    var address: Address?
    let dateOfBirth: Date?
    var passCard: PassCard?
    var age: Int? {
        if let birthday = dateOfBirth {
            return birthday.years(from: Date())
        } else {
            return nil
        }
    }
    
    init(firstName: String, lastName: String, dateOfBirth: Date?) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
    }
    
    convenience init(firstName: String, lastName: String, address: Address, dateOfBirth: Date?) {
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        self.address = address
    }
    
    func issuePass(type: PassType) throws -> PassCard {
        guard let passAccess = permissions.list[type] else { throw PassError.noPermissions }
        let passCard = PassCard(accesses: passAccess, passHolder: self)
        switch type {
        case .freeChildGuest: if self.age != nil && self.age! < 5 {
            return passCard
        } else {
            throw PassError.childOverFive
            }
        case .hourlyFoodService, .hourlyMaintenance, .hourlyRideService, .manager: if self.firstName != nil && self.lastName != nil && self.address != nil {
            return passCard
        } else {
            throw PassError.insufficientPersonalInfo
            }
        default: return passCard
        }
    }
}
