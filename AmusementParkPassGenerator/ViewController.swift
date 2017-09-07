//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Bryan Richardson on 9/3/17.
//  Copyright © 2017 Bryan Richardson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Testing
        let swipeTestArea: AccessGroups = .rideAreas
        // test 1
        /*
        let myAddress = Address(streetAddress: "123 Street", city: "City", state: "CT", zipCode: "12345")
        let person = PassHolder(firstName: "Joe", lastName: "Smith", address: myAddress, dateOfBirth: "12/22/1974")
        let testPass: PassType = .manager
        */
        
        // test 2
        /*
        let person = PassHolder(dateOfBirth: "12/22/2016")
        let testPass: PassType = .freeChildGuest
        */
        // test 3
        let person = PassHolder(firstName: "Jimmy", lastName: "Da Fish", dateOfBirth: "1/2/1903")
        let testPass = PassType.vipGuest
        
        do {
            person.passCard = try person.IssuePass(type: testPass)
            
        } catch let error {
            print("\(error)")
        }
        // Do any additional setup after loading the view, typically from a nib.
        if let passCard = person.passCard {
            passCard.swipeTest(for: .employeeAreas)
            passCard.swipeTest(for: .discounts)
            //for eachAccess in passCard.accesses {
            //    print(eachAccess.rawValue)
            //}
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

