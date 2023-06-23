//
//  File.swift
//  Calculator
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
struct Matieres: Identifiable, Equatable{
   static func == (lhs: Matieres, rhs: Matieres) -> Bool {
        lhs.id == rhs.id
    }
    let id : UUID
    var name: String
    var coef : Int
     var note : Double
   public init(name: String, coef: Int, note: Double) {
        self.id = UUID()
        self.name = name
        self.coef = coef
        self.note = note
    }
   public init(name: String,note: Double,coef:Int) {
        self.id = UUID()
        self.name = name
        self.note = note
        self.coef=coef
    }
  
}
  
