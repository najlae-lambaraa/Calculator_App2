//
//  UEview.swift
//  Calculator
//
//  Created by etudiant on 26/05/2023.
//

import SwiftUI
 struct UEview: View {
     @ObservedObject var bloc : BlocVM
    @ObservedObject var ue: UeVM
    
    var body: some View {
        
            VStack(alignment : .leading){
                HStack {
                    Text(ue.name)
                    Spacer()
                    Text("\(ue.coef)")
                                        
                    NavigationLink(destination: EditView(ue: ue, bloc: bloc) ){
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.blue)
                        
                    }
                   
                }
                .padding(.horizontal, 16.0)
               
                HStack {
                    Capsule()
                        .fill(ue.generalNote < 10 ? .red : .blue)
                        .frame(height: 20)
                        .frame(width: CGFloat(ue.generalNote) * 10)
                        .background(Color.clear)
                    Text(String(ue.generalNote))
                    
                }.padding()
                Divider()
                 
                 
            }
        
        
    }
}

struct UEview_Previews: PreviewProvider {
    static var previews: some View {
        let ue = StubUE().loadUEs().first!
        let UeVM = UeVM(withModel: ue)
        
        UEview(bloc: BlocVM(withModel: Bloc(name: "Projet/Stage", ListUE : StubUE().loadUeStage_Proj(),isUq: true)), ue: UeVM)
        
    }
}
