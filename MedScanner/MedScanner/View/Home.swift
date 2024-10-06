//
//  Home.swift
//  MedScanner
//
//  Created by Dan Frimu on 9/11/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct Home: View {
    @State var nombre = ""
    @State var medicamento:Medicamento.ReturnedJson? = nil
    // @State var txtTitle = "Búsquedas recientes"
    @State var txtTitle = "Búsqueda de Medicamento"
    //@AppStorage("uid") var userId: String = ""
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @State var opcionSeleccionada: OpcionSelecionada = .ninguna
    var body: some View {
        VStack{
            HStack{
                TextField("Buscar medicamento", text: $nombre).padding(15).border(Color.gray, width: 0.5).padding(10).autocorrectionDisabled().onSubmit {
                    Task{
                        do{
                            medicamento = try await Medicamento().getMedicamentosUrl(texto: nombre)
                            txtTitle = "Resultados para \(nombre)"
                        }catch{
                            print("Error")
                        }
                    }
                }
                Button(action: {
                   /* do{
                       try auth.signOut()
                        //insertarBusqueda(db: db)
                        //userId = ""
                        print("usuario deslogueado")
                    } catch let signOutError as NSError {
                        print("Error signing out: \(signOutError.localizedDescription)")
                    }
                    */
                }) {
                    Image(systemName: "camera").padding(.horizontal,10)
                }
            }
            
            NavigationStack{
                Text(txtTitle).font(.system(size: 20, weight: .bold, design: .rounded ))
                List(medicamento?.resultados ?? []){ medicamento in
                    NavigationLink(destination: Medicamento_Desc(nregistro: medicamento.nregistro)) {
                        MedicamentoRow(medicamento: medicamento)
                        EmptyView().opacity(0)
                    }
                }.listRowSpacing(10).listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity )
    }
}

/*
func insertarBusqueda(db: Firestore, userid: String?, nregistro: String, nombre: String, laboratorio: String) {

   let insert =  db.collection("users").addDocument(data: [
        "userid": userid ?? "",
            "nregistro": nregistro,
        "nombre": nombre,
        "laboratorio": laboratorio
    ])
    print(insert)

}
*/
#Preview {
    Home()
}
