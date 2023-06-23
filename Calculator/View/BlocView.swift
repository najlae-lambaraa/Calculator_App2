//
//  BlocView.swift
//  Calculator
//
//  Created by etudiant on 20/06/2023.
//

import SwiftUI

struct BlocView: View {
    @ObservedObject var manager : ManagerVM
  
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(alignment: .leading){
                    Text("Calculette")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 12.0)
                    VStack(alignment: .leading){
                        
                        HStack {
                            Image(systemName: "doc.on.doc.fill")
                            
                                .foregroundColor(.accentColor)
                            Text("Block")
                                .font(.title)
                            
                            
                        }
                        VStack{
                            Text("Vous devez avoir la moyenne à chacun de ces blocs pour avoir votre diplome ")
                                .padding(.horizontal, 16.0)
                          
                        }
                        HStack {
                            Image(systemName: "doc.on.doc.fill")
                                .foregroundColor(.accentColor)
                            Text("Total")
                            Spacer()
                           // BlocItem(total: .constant( manager.total), name: .constant(""))
                            Text(String(manager.total))
                           

                            Image(systemName: "graduationcap.circle.fill")
                            
                            
                           
                           
                           
                        }
                        
                  
                        HStack {
                            Image(systemName: "doc.on.doc.fill")
                            
                                .foregroundColor(.accentColor)
                            Text("Projet/Stage")
                            Spacer()
                            ForEach(manager.blocs) { item in
                                if item.isUnique {
                                    BlocItem(total: .constant(item.TotalNote), name: .constant(item.name))
                                    Divider()
                                }
                               
                            }
                            
                            Image(systemName: "graduationcap.circle.fill")
                        
                        }
                        
                    }.padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }}
        }
    }
}

struct BlocView_Previews: PreviewProvider {
    static var previews: some View {
        
        let bloc =  [
            BlocVM(withModel: Bloc(name: "Total", ListUE: StubUE().loadUEs(), isUq: false)),
            BlocVM(withModel: Bloc(name: "", ListUE: StubUE().loadUeStage_Proj(), isUq: true))
        ]
        BlocView(manager: ManagerVM(withBeds: bloc))
    }
}
