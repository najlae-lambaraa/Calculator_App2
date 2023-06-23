//
//  ItemView.swift
//  Calculator
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var ue : UeVM
    @ObservedObject var bloc : BlocVM
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                VStack(alignment : .leading){
                    
                    
                    
                    HStack {
                        Text(ue.name)
                        Spacer()
                        Text("\(ue.coef)")
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal, 16.0)
                    
                    HStack {
                        Capsule()
                            .fill(ue.generalNote < 10 ? .red : .blue)
                            .frame(height: 20)
                            .frame(width: CGFloat(ue.generalNote) * 10) // Utilisez la valeur de la note pour définir la largeur de la barre
                            .background(Color.clear)
                        Text("\(ue.generalNote)")
                    }.padding()
                    HStack{
                        Image(systemName: "x.circle.fill")
                        
                        Text("Coefficient :")
                        Text("\(ue.coef)")
                        
                    }
                    HStack{
                        Image(systemName: "note.text")
                        Text("Détails des notes")
                        
                        
                        
                    }
                 
                    Divider()
                       
                    ForEach(ue.someMatiereVM) { mat in
                        
                        MatiereView(mat: mat, ue: ue, bloc: bloc )
                        
                    }
                    
                }
                
                
            }
            
            
            
        }
        .navigationBarItems(
            
            trailing:
                HStack {
                    Button(action: {
                        self.ue.onEditing()
                        
                    }) {
                        Text("Edit")
                            .foregroundColor(Color.blue)
                        
                    }
                    
                    
                }
            
        )
        
        .sheet(isPresented: $ue.isEditing){
            
            NavigationStack{
                
                Editpage(editUe: ue)
                
                    .toolbar{
                        ToolbarItem(id: "done", placement: .confirmationAction){
                            Button(action: {
                                // self.isEditing.toggle()
                                self.ue.onEdited(isCancelled: true)
                                print(self.ue.isEditing)
                            }){
                                Text("Done")
                            }
                        }
                        ToolbarItem(id: "cancel", placement: .cancellationAction){
                            Button(action: {
                                self.ue.onEdited()
                            }){
                                Text("Cancel")
                            }
                        }
                        
                        ToolbarItem(id: "Add", placement: .cancellationAction){
                            Button(action: {
                                self.ue.onAdding()
                                
                                print(ue.isAdding)
                                
                            }) {
                                Text("Ajouter")
                            }
                            
                        }
                    }
                    }
            
                    .navigationTitle("Edit: \(ue.name)")
                
                
            }
        
        .sheet(isPresented: $ue.isAdding){
            NavigationStack{
                AddMat(mat: self.ue.addedItem ?? MatieresVM())
                
                
                    .toolbar{
                        ToolbarItem(id: "done", placement: .confirmationAction){
                            Button(action: {
                          
                                self.ue.onAdded()
                            }){
                                Text("Done")
                            }
                        }
                        ToolbarItem(id: "cancel", placement: .cancellationAction){
                            Button(action: {
                                self.ue.onAdded()
                            }){
                                Text("Cancel")
                                    
                            }
                        }


                    }

            }
           
        }
            
        }
    }

    



struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        let ue = StubUE().loadUEs().last!
        EditView(ue:UeVM(withModel:ue), bloc : BlocVM(withModel: Bloc(name: "Stage", ListUE: StubUE().loadUeStage_Proj(), isUq: true)))
        
        
    }
}
