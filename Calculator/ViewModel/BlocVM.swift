//
//  BlocVM.swift
//  Calculator
//
//  Created by etudiant on 15/06/2023.
//

import Foundation


class BlocVM : ObservableObject,Identifiable,Equatable,Hashable{
    
    public init(){}
   
    static func == (lhs: BlocVM, rhs: BlocVM) -> Bool {
           lhs.id == rhs.id
       }
    public var id: UUID { model.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.TotalNote)
        }
    init(withBloc blc : Bloc) {
        self.model = blc
         
     }
    @Published var model: Bloc = Bloc(name: "Total", ListUE: StubUE().loadUEs(),isUq: false){
        
        willSet(newValue) {
            if !self.someUeVM.map({$0.model}).compare(to: newValue.listUE){
                        self.someUeVM.forEach { uevm in
                            uevm.unsubscribe(with: self)
                        }
                    }
                }
            didSet {
                if self.model.name != self.name {
                    self.name = self.model.name
                }
              
                if self.model.isUnique != self.isUnique {
                    self.isUnique = self.model.isUnique
                }
                
              
                
                
                if !self.model.listUE.compare(to: self.someUeVM.map({$0.model})){
                    self.someUeVM = self.model.listUE.map({UeVM(withModel: $0)})
                    self.someUeVM.forEach{
                        uev in uev.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
                    }
                            }
                let not = updateTotalNote()
                if not != self.TotalNote {
                    self.TotalNote = not
                }
                self.onNotifyChanged()
            }
       
        }
    
    @Published var name: String = "" {
           didSet {
               if self.model.name != self.name {
                   self.model.name = self.name
               }
           }
       }
    
  
    @Published var someUeVM: [UeVM] = [] {
           didSet {
               let someModelUe = self.someUeVM.map({$0.model})
               if !self.model.listUE.compare(to: someModelUe){
                   self.model.listUE = someUeVM.map({$0.model})
               }
           }
       }
    public init(withModel model: Bloc){
           self.model = model
       }
    
    @Published var isEditing: Bool = false
        
        private var copy: BlocVM { BlocVM(withModel:  self.model) }
        private var notificationFuncs: [AnyHashable:(BlocVM) -> ()] = [:]
        var editedCopy: BlocVM?
        
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
    func onNotifyChanged(source:UeVM){
        if let index = self.model.listUE.firstIndex(where: {$0 == source.model}) {
            self.model.listUE[index] = source.model
        }
            self.objectWillChange.send()
        }
    
    @Published  var TotalNote: Double = 0.0 {
        didSet{
       let not = updateTotalNote()
           
            if not != self.TotalNote {
                self.TotalNote = not
             }
             self.onNotifyChanged()
        }
    }
    private func onNotifyChanged(){
        for f in notificationFuncs.values {
            print("notif")
                f(self)
            }
        }
    
    
    public func updateTotalNote()->Double {

        let totalnote = self.someUeVM.reduce(0.0) { $0 + Double($1.generalNote) * Double($1.coef) }
        let totalCoef = self.someUeVM.reduce(0.0) { $0 + Double($1.coef) }
        
        print("bloc")
        print( totalnote / totalCoef)
          return totalnote / totalCoef

      }
  

    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (BlocVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }

    
    @Published var isUnique : Bool = false {
        didSet{
            if self.isUnique != self.model.isUnique {
                self.model.isUnique = self.isUnique
            }
        }
    }
  


}


/* public let id: UUID
 public var name: String
 public var moyenneBloc: Double
 public var listUE: [UE]*/
/*UE = list de matiere*/
