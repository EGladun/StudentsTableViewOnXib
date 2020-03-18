//
//  StudentClass.swift
//  StudentsProject
//
//  Created by Egor on 18.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

class Student{
    var name: String
    var surname: String
    var rate: Int
    var gender: String
    var marks: [Int] = []
    var internetProfile: String?
    
    init(name: String, surname: String, rate: Int, gender: String) {
        self.name = name
        self.surname = surname
        self.rate = rate
        self.gender = gender
        self.greeting()
        
    }
    
    func greeting(){
        print("Hello, my name is \(String(describing: self.name)) \(String(describing: self.surname)), i'm \(String(describing: self.gender)) and i have rate equal \(String(describing: self.rate))")
    }
    
    func addMark(mark: Int){
        self.marks.append(mark)
        print("\(String(describing: self.name))'s marks are \(self.marks)")
    }
    
    func addProfile(profile: String){
        self.internetProfile = profile
    }
}
