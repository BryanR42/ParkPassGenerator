//
//  People.swift
//  AmusementParkPassGenerator
//
//  Created by Bryan Richardson on 9/3/17.
//  Copyright © 2017 Bryan Richardson. All rights reserved.
//

import Foundation


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

// everything is optional? because we don't need personal info for certain pass types, but I still want to associate a Person with every pass for future scaleability.

class PassHolder: Person {
    var firstName: String?
    var lastName: String?
    var address: Address?
    var dateOfBirth: Date?
    var passCard: PassCard?
    var age: Int? {
        if let birthday = dateOfBirth {
            return birthday.years(from: Date())
        } else {
            return nil
        }
    }
    
    init(dateOfBirth: String?) {
        self.dateOfBirth = convertDate(from: dateOfBirth)
    }
    
    convenience init(firstName: String, lastName: String, dateOfBirth: String?) {
        self.init(dateOfBirth: dateOfBirth)
        self.firstName = firstName
        self.lastName = lastName
        
    }
    
    convenience init(firstName: String, lastName: String, address: Address, dateOfBirth: String?) {
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        self.address = address
    }
}
//  MARK: - Helper Functions


    // not sure about this but I'm using the mockup as a guide and hoping there is a way to restrict the date input format when we get to the user interface?
func convertDate(from dateString: String?) -> Date? {
    var dateComponents = DateComponents()
    if let dateString = dateString {
        let dateArray = dateString.components(separatedBy: "/")
        let calendar = Calendar(identifier: .gregorian)
        dateComponents.calendar = calendar
        dateComponents.month = Int(dateArray[0])
        dateComponents.day = Int(dateArray[1])
        dateComponents.year = Int(dateArray[2])
        return dateComponents.date
    } else {
        return nil
    }
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: date).year ?? 0
    }
}

