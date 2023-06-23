
import SwiftUI

struct EditMatView: View {
    @ObservedObject var matiere : MatieresVM
    var body: some View {
        
        NavigationLink{
            Form{
               
                    
                    TextField("", text: $matiere.name, prompt: Text("enter the  name"))
                
                }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Matiere")
            }
         label: {
             
                HStack{
                    Text("Name")
                    Spacer()
                    Text(matiere.name)
                        .foregroundColor(.gray)
                }
            
        }
            NavigationLink{
                Form{
                    
                        TextField("", value: $matiere.coef, format: .number, prompt: Text("enter the coef"))
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("entez coef")
            }
        label: {
            HStack{
                Text("Coef")
                Spacer()
                Text(String(matiere.coef))
                    .foregroundColor(.gray)
            }
        }
        
        
        NavigationLink{
            Form{
               
                    TextField("", value: $matiere.note, format: .number, prompt: Text("enter the coef"))
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("entez coef")
        }
    label: {
        HStack{
            Text("Note")
            Spacer()
            Text(String(matiere.note))
                .foregroundColor(.gray)
        }
    }
         
       
    }
    
}

struct EditMatView_Previews: PreviewProvider {
    static var previews: some View {
        let matiere = MatieresVM(withModel: StubMatiere().UE4().first!)
        EditMatView(matiere: matiere)
        
    }
}
