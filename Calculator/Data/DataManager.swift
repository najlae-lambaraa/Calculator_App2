//
//  DataManager.swift
//  Calculator
//
//  Created by etudiant on 20/06/2023.
//

import Foundation
public protocol DataManager {
    func loadUEs() -> [UE]
    func loadUeStage_Proj() -> [UE] 
    func save(ues: [UE])
}
