//
//  Bed.swift
//  Calculator
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
public struct UE: Identifiable,Equatable {
    public static func == (lhs: UE, rhs: UE) -> Bool {
           lhs.id == rhs.id
       }
     public let id: UUID
     var name: String
     var coef : Int
    var listMatiere: [Matieres]
    var generalNote: Double{
        return Double(listMatiere.reduce(0) { $0+$1.note }) / Double(listMatiere.count)
             }

    
     init(name: String,listMatiere: [Matieres],coef:Int) {
         self.id = UUID()
        self.name = name
        self.listMatiere = listMatiere
        
        self.coef=coef
    }


}
