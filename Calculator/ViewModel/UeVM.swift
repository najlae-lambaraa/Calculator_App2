//
//  UeVM.swift
//  Calculator
//
//  Created by etudiant on 14/06/2023.
//

import Foundation
class UeVM : ObservableObject,Identifiable,Equatable,Hashable{
    public init(){}
   
    
    @Published
        var isEditing: Bool = false
    private var notificationFuncs: [AnyHashable:(UeVM) -> ()] = [:]
        private var copy: UeVM  { UeVM (withModel: self.model) }

    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (UeVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }
        var editedCopy: UeVM?
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.generalNote)
        }
        func onEditing(){
            editedCopy = self.copy
            isEditing = true
            isAdding = false
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
    var addedItem: MatieresVM? = MatieresVM(withModel: Matieres(name: "", note: 0.0, coef: 0)) /// ?

   
   
    static func == (lhs: UeVM, rhs: UeVM) -> Bool {
           lhs.id == rhs.id
       }
    

    
    
    
    @Published var model : UE = StubUE().loadUEs().first!{
        willSet(newValue) {
            if !self.someMatiereVM.map({$0.model}).compare(to: newValue.listMatiere){
                        self.someMatiereVM.forEach { $0.unsubscribe(with: self) }
                    }
                }
        didSet{
            if self.model.name != self.name {
                self.name = self.model.name
            }
            if self.model.coef != self.coef {
                          self.coef = self.model.coef
                      }
            if !self.model.listMatiere.compare(to: self.someMatiereVM.map({$0.model})){
                self.someMatiereVM = self.model.listMatiere.map({MatieresVM(withModel:  $0)})
                self.someMatiereVM.forEach { mvm in
                    mvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
                                }
           
            }
            
            
            let note = updateTotalNote()
            if note != self.generalNote {
                self.generalNote = note
            }
            self.onNotifyChanged()
            
            
        }
    }

    
    
    
    
    
    public var id: UUID { model.id }
    @Published var name: String = "" {
           didSet {
               if self.model.name != self.name {
                   self.model.name = self.name
               }
           }
       }
    
    @Published var coef: Int = 0 {
           didSet {
               if self.model.coef != self.coef {
                   self.model.coef = self.coef
               }
           }
       }
   @Published
    var generalNote : Double = 0.0 {
            didSet {
                let note = updateTotalNote()
                if note != self.generalNote {
                    self.generalNote = note
                }
            }
        }
 
    
    
    public func updateTotalNote()->Double {
 

        let totalNote = someMatiereVM.reduce(0.0) { $0 + Double($1.note) * Double($1.coef) }
        let totalCoef = someMatiereVM.reduce(0.0) { $0 + Double($1.coef) }
       print("ue")
        print(self.someMatiereVM.count)
        return totalNote/totalCoef

    }
    @Published var someMatiereVM: [MatieresVM] = [] {
           didSet {
               let someModelMatiere = self.someMatiereVM.map({$0.model})
               if !self.model.listMatiere.compare(to: someModelMatiere){
                   self.model.listMatiere = someMatiereVM.map({$0.model})
               }
           }
       }
    public init(withModel model: UE){
           self.model = model
       }

    
   // var addedItem: MatieresVM?
        
        @Published
        var isAdding: Bool = false
        
        func onAdding() {
            addedItem = MatieresVM()
            isEditing = false
            isAdding = true
        }
        
        func onAdded(isCancelled cancel:Bool = false) {
            if !cancel {
                if let addedItem = addedItem {
                    self.someMatiereVM.append(addedItem)
                }
            }
            addedItem = nil
            isAdding = false
        }
    func onDeleted(_ matieres:MatieresVM, isCancelled cancel: Bool = false) {
            if !cancel {
                if self.someMatiereVM.contains(matieres) {
                    self.someMatiereVM.removeAll(where: {$0 == matieres})
                }
            }
        }
    func onNotifyChanged(){
       for f in notificationFuncs.values {
               f(self)
           }
       }
    func onNotifyChanged(source:MatieresVM){
        if let index = self.model.listMatiere.firstIndex(where: {$0 == source.model}) {
            self.model.listMatiere[index] = source.model
        }
            self.objectWillChange.send()
        }



}
/*public let id: UUID
 public var name: String
 public var coef : Int
 public var listMatiere: [Matieres]
 public var generalNote: Double {*/
