//
//  BedView.swift
//  Calculator
//
//  Created by etudiant on 23/05/2023.
//



import SwiftUI

struct HomeView: View {
    @StateObject  var manager: ManagerVM
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    VStack(alignment: .leading){
                        /*Text("Calculette")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.leading, 12.0)*/
                        VStack(alignment: .leading){
                            
                           
                            
                            BlocView(manager: manager)
                           
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("Détail des UEs")
                                    Spacer()
                                    
                                }
                            
                                ForEach(manager.blocs) { item in
                                    ForEach(item.someUeVM) {
                                        ue in
                                    
                                         UEview(bloc: item, ue:  ue)
                                    }
                                    
                                   
                                   
                                }
                                
                                Divider()
                                
                            }
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            
                            
                        }
                        
                    }}
            }
        }
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let managerVM = ManagerVM(withBeds: [BlocVM(withModel: Bloc(name: "Total", ListUE: StubUE().loadUEs(), isUq: false)),BlocVM(withModel: Bloc(name: "Projet", ListUE: StubUE().loadUeStage_Proj(),isUq: true))])
        HomeView(manager: managerVM )
    }
}

