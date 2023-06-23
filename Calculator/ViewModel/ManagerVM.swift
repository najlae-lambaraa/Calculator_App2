//
//  ManagerVM.swift
//  Calculator
//
//  Created by etudiant on 20/06/2023.
//

import Foundation


class ManagerVM: ObservableObject,Hashable {
    @Published var blocs: [BlocVM] = []
    static func == (lhs: ManagerVM, rhs: ManagerVM) -> Bool {
            lhs.blocs.compare(to: rhs.blocs)
        }
    func onNotifyChanged(source:BlocVM){
            self.objectWillChange.send()
        }
    
    public init(withBeds blocs: [Bloc]){
        self.blocs = blocs.map({BlocVM(withModel: $0)})
        self.blocs.forEach { blocvm in
            blocvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
               }
    }

    public init(withBeds blocs: [BlocVM]){
        self.blocs = blocs
        self.blocs.forEach { blocvm in
            blocvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
        }
    }
 
        //var addedItem: BlocVM?
        
        //  @Published var isAdding: Bool = false
        
        /*  func onAdding() {
         addedItem = BlocVM()
         isAdding = true
         }*/
        var total : Double {
            return Double(blocs.reduce(into: 0) { $0 + $1.TotalNote }) / Double(blocs.count)
        }
        /* func onAdded(isCancelled cancel:Bool = false) {
         if !cancel {
         if let addedItem = addedItem {
         self.blocs.append(addedItem)
         }
         }
         addedItem = nil
         isAdding = false
         }*/
      
        func hash(into hasher: inout Hasher) {
            hasher.combine("Manager")
        }
        
        
        
        
        
        
    
  
}
