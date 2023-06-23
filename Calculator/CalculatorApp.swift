//
//  CalculatorApp.swift
//  Calculator
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

@main
struct CalculatorApp: App {
    let ueViewModel = UeVM()
    var blocs = [
        BlocVM(withModel:     Bloc(name: "Total", ListUE:  StubUE().loadUEs(), isUq: false)),
        BlocVM(withModel:   Bloc(name: "Projet/Stage", ListUE: StubUE().loadUeStage_Proj(), isUq: true))
      ]
    var body: some Scene {
        WindowGroup {
            HomeView(manager : ManagerVM(withBeds: blocs))
                      
               }
    }
}
