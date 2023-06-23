//
//  BlocItem.swift
//  Calculator
//
//  Created by etudiant on 23/06/2023.
//

import SwiftUI

struct BlocItem: View {
    @Binding var total : Double
    @Binding var name : String

    var body: some View {
        HStack(spacing: 15) {
            Grid{
                GridRow {
                    
                    Text(self.name)
                    Text( self.total,format: .number)
                    
                                            
                }
            }
           
            
        }
    }
}

struct BlocItem_Previews: PreviewProvider {
    static var previews: some View {
        BlocItem(total: .constant( 15.5), name: .constant( "Total"))
    }
}
