//
//  MatiereView.swift
//  Calculator
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI

struct MatiereView: View {
    @ObservedObject var mat: MatieresVM
    @ObservedObject var ue : UeVM
    @ObservedObject var bloc : BlocVM
   
    @State private var isClicked : Bool = false;
    @State var isEditing: Bool = false
    
    var body: some View {
        
        VStack(alignment : .leading){
            
            HStack {
                Text(mat.name)
                    .font(.title2)
                Spacer()
                Text("\(mat.coef)")
                    .font(.title2)
                    .padding(.horizontal, 30.0)
                
                
                
                
            }
            .padding(.horizontal, 11.0)
            Button (action:{
                isClicked.toggle()
                self.mat.onEditing()
            }){
                Image(systemName: isClicked ?  "lock.open": "lock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 11.0)
                
            }
            
            
            HStack {
                GeometryReader { geometry in
                    HStack {
                        Capsule()
                            .fill(mat.note < 10 ? .red : .green)
                            .frame(height: 20)
                            .frame(width: CGFloat(mat.note) / 30 * geometry.size.width)
                            .gesture(
                                isClicked ?
                                DragGesture(minimumDistance: 0)
                                    .onChanged({ value in
                                        let newNote = value.location.x / geometry.size.width * 20
                                        mat.note = min(max(newNote, 0), 20)
                                    })
                                :
                                    DragGesture(minimumDistance: 0).onChanged({_ in })
                                    
                            )
                        Text("\(String(mat.note))")
                        if !isClicked{
                                                  Image("gouffle")
                                                      .resizable()
                                                      .frame(width: 20, height: 20)
                                              }
                    }
               
                }
                
                .padding(.horizontal, 25.0)
              
                
            }
            Divider()
              
            
        }
        
    }
}

struct MatiereView_Previews: PreviewProvider {
    static var previews: some View {
        MatiereView(mat: MatieresVM(withModel: Matieres(name: "JAVA", coef: 6, note: 19)), ue: UeVM(withModel: StubUE().loadUeStage_Proj()[0]),bloc: BlocVM(withModel: Bloc(name: "", ListUE: StubUE().loadUeStage_Proj(), isUq: true)))
        
       
    }
}
