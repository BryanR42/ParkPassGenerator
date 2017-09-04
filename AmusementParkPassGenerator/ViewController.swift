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
        let person = PassHolder(firstName: "Joe", lastName: "Smith", dateOfBirth: "12/22/1974")
        do {
            try person.passCard = IssuePass(type: .freeChildGuest, to: person)
            print(person.passCard!.passHolder!.age!)
        } catch PassError.childOverFive {
            print("Child not elligible, \(person.age!) is too old")
        
        
        } catch let error {
            fatalError("\(error)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

