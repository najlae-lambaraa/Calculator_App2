//
//  Bloc.swift
//  Calculator
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
public struct Bloc: Identifiable,Equatable {
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        lhs.id == rhs.id
    }
    public let id: UUID
    public var name: String
 
    public var listUE: [UE]
    public var isUnique : Bool
    var total : Double {
        return Double(listUE.reduce(0) { $0 + $1.generalNote }) / Double(listUE.count)
        }
    
 
    init(name: String, ListUE : [UE], isUq : Bool) {
        self.id = UUID()
        self.name = name
        self.listUE = ListUE
        self.isUnique = isUq
        
    }
    
  
}
