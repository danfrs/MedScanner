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
                    // Apertura camara para lectura de nombre del medicamento
                }) {
                    Image(systemName: "camera").padding(.horizontal,10).disabled(true)
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

#Preview {
    Home()
}
