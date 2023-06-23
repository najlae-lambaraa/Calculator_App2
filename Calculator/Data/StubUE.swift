//
//  StubUE.swift
//  Calculator
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
public struct StubUE  : DataManager {
  
    
    public func loadUeStage_Proj() -> [UE] {
            return [
                UE(name: "Projet", listMatiere: StubMatiere().UE6(),  coef: 6),
                UE(name: "Stage", listMatiere: StubMatiere().UE7(),  coef: 6)
            ]
    }
    
    public func loadUEs()-> [UE]{
         
        let ue1 = UE(name: "UE1 Génie logiciel", listMatiere: StubMatiere().UE1(),  coef: 6)
        let ue2 = UE(name: "UE2 Systèmes et réseaux", listMatiere: StubMatiere().UE2(), coef: 6)
        let ue3 = UE(name: "UE3 Insertion Professionnelle", listMatiere:StubMatiere().UE3(), coef: 6)
        let ue4 = UE(name: "UE4 Technologies Mobiles 1", listMatiere: StubMatiere().UE4(), coef: 9)
        let ue5 = UE(name: "UE5 Technologies Mobiles 2", listMatiere: StubMatiere().UE5(), coef: 9)

        let ue6 = UE(name: "UE6 Projet", listMatiere: StubMatiere().UE6(), coef: 9)

        let ue7 = UE(name: "UE7 Stage", listMatiere: StubMatiere().UE7(), coef: 15)

       return [ue1, ue2,ue3,ue4,ue5,ue6,ue7]
     }
    public func save(ues: [UE]) {
        }
}
