//
//  Editpage.swift
//  Calculator
//
//  Created by etudiant on 20/06/2023.
//

import Foundation


import SwiftUI


struct Editpage: View {
    @ObservedObject var editUe:UeVM
    @State var isEditing: Bool = false
    var body: some View {
        NavigationStack{
            
            VStack{
                Form{
                    NavigationLink{
                        Form{
                            TextField("", text: $editUe.name, prompt: Text("enter the  name"))
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Name")
                    }
                label: {
                    HStack{
                        Text("Name")
                        Spacer()
                        Text(editUe.name)
                            .foregroundColor(.gray)
                    }
                }
                    NavigationLink{
                        Form{
                            TextField("", value: $editUe.coef, format: .number, prompt: Text("enter the coef"))
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("entez coef")
                    }
                label: {
                    HStack{
                        Text("Entrez coef")
                        Spacer()
                        Text(String(editUe.coef))
                            .foregroundColor(.gray)
                    }
                }
               
                        Label("Liste des matières", systemImage: "newspaper.fill").font(.title).padding()
                    
                    ForEach(editUe.someMatiereVM ){ mat in
                       
                        NavigationLink{
                            EditMatView(matiere : mat)
                            .navigationTitle("Matiere")
                        }
                        
                    label: {
                        HStack{
                            Text(mat.name)
                        }
                        .swipeActions(edge:.trailing){
                           
                                Button(role: .destructive) {
                                    
                                    self.editUe.onDeleted(mat)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                           
                    }
                    }
                     
                        Spacer()
                    }
                    
                      
                 
                
                    
                }
              
                
            }
        }
    }
}
    
    struct Editpage_Previews: PreviewProvider {
        static var previews: some View {
            let ue = StubUE().loadUEs().first!
            Editpage(editUe:UeVM(withModel:ue))
        }
    }
    

