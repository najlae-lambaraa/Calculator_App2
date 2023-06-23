//
//  MatieresVM.swift
//  Calculator
//
//  Created by etudiant on 09/06/2023.
//

import Foundation

class MatieresVM : ObservableObject, Identifiable, Equatable{
    
    public init(){}
    @Published
    var isEditing: Bool = false
    init(withMat mat : Matieres) {
        
        self.model = mat
    }
    private var copy: MatieresVM { MatieresVM(withModel: self.model) }
    
    var editedCopy: MatieresVM?
    
    func onEditing(){
        editedCopy = self.copy
        isEditing = true
    }
    
    func onEdited(isCancelled cancel: Bool = false) {
        if !cancel {
            if let editedCopy = editedCopy {
                self.model = editedCopy.model
            }
        }
        editedCopy = nil
        isEditing = false
    }
    private var notificationFuncs: [AnyHashable:(MatieresVM) -> ()] = [:]
    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (MatieresVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }
    static func == (lhs: MatieresVM, rhs: MatieresVM) -> Bool {
        lhs.id ==  rhs.id
    }
    
    func notifyChanged(){
        for f in notificationFuncs.values {
                f(self)
            }
        }
       public init(withModel model: Matieres){
           self.model = model
       }
    public var id: UUID { model.id }
    
    @Published var model: Matieres = Matieres(name: "", note: 0 , coef: 0){
        didSet{
            if self.model.name != self.name{
                self.name = self.model.name
            }
            
            if self.model.coef != self.coef{
                self.coef = self.model.coef
            }
            if self.model.note != self.note{
                self.note = self.model.note
                
            }
            self.notifyChanged()
           
        }
    }
    
    @Published var name : String = ""{
        didSet{
          
            if self.model.name != self.name {
                self.model.name = self.name
            }
            
        }
    }
    @Published var coef : Int = 0{
        didSet{
           
            if self.model.coef != self.coef {
                self.model.coef = self.coef
           
            }
            
        }
    }
    @Published var note : Double = 0{
        didSet{
            if self.model.note != self.note{
                self.model.note = self.note
                
            }
            
        }
    }
  
    
   
    
}
/*
 public var name: String
 public var coef : Int
 public var note : Double
 */
