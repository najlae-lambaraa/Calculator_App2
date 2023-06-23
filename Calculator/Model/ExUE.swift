//
//  ExUE.swift
//  Calculator
//
//  Created by etudiant on 26/05/2023.
//

import Foundation
extension UE {
    struct Data: Identifiable{
        public let id: UUID
        public var name: String
        
        public var coef : Int
        public var listMatiere: [Matieres]
        var generalNote: Double {
            return Double(listMatiere.reduce(into: 0) { $0 + $1.note }) / Double(listMatiere.count)
                 }
    }
    
    var data : Data {
            Data(
                id : self.id,

                 name:self.name,
                 coef:self.coef ,
                listMatiere : self.listMatiere)
        }
    mutating func update(from data : Data){
         guard data.id == self.id else {return}
         self.name = data.name
         
         self.coef = data.coef
         self.listMatiere = data.listMatiere
     }
 
}
class ExUE : ObservableObject{
    var original : UE
    @Published var model : UE.Data
    @Published var isEditing : Bool = false
    
    init(withUe ue : UE) {
        self.original = ue
        self.model = original.data
    }
    
    func onEditing(){
        model = original.data
        isEditing = true
    }
    
    
    func onEdited(isCancelled : Bool = false){
        if(!isCancelled){
            original.update(from: model)
        }
        isEditing = false
        model = original.data
    }
    
    
}
