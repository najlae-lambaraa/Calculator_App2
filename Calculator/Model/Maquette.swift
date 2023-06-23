//
//  Maquette.swift
//  Calculator
//
//  Created by etudiant on 30/05/2023.
//

import Foundation
struct Maquette {
    
    var listeBlocs: [Bloc]
    var listeUEs: [UE]
    
    public init( listeBlocs: [Bloc], listeUEs: [UE]) {
        self.listeBlocs = listeBlocs
        self.listeUEs = listeUEs
    }
    
}
