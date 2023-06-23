//
//  AddMat.swift
//  Calculator
//
//  Created by etudiant on 21/06/2023.
//

import SwiftUI

struct AddMat: View {
    @ObservedObject var mat : MatieresVM
    var body: some View {
        VStack{
            HStack{
                Text("Nom : ")
                TextField("Name", text: $mat.name)
             }
            Divider()
            HStack{
                Text("Coef : ")
                TextField("Coefficient", value: $mat.coef, format: .number)
                
            }
        }.frame(height: 250)
        
    }
}



struct AddMat_Previews: PreviewProvider {
    static var previews: some View {
        AddMat(mat: MatieresVM())
    }
}
