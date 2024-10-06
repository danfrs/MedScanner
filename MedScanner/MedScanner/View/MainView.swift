//
//  MainView.swift
//  MedScanner
//
//  Created by Dan Frimu on 9/11/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var autenticacion: Autenticacion
    @State private var opcionSeleccionada: OpcionSelecionada = .ninguna
    var body: some View {
        if(autenticacion.sesion == nil){
            Login()
        } else if (opcionSeleccionada != .ninguna){
            switch opcionSeleccionada {
            case .primera:
                Home()
            case .segunda:
                Home()
            case .tercera:
                ProfileView()
            case .ninguna:
                Home()
                }
        } else if(autenticacion.sesion != nil) {
            Home()
        }
        if(autenticacion.sesion != nil){
            HStack {
                Button(action: { opcionSeleccionada = .primera }, label: {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                })
                
                Spacer()
                
                Button(action: { opcionSeleccionada = .segunda }, label: {
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                })
                
                Spacer()
                
                Button(action: { opcionSeleccionada = .tercera }, label: {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                })
            }.padding(.horizontal, 30)
        }
    }
}

enum OpcionSelecionada {
    case primera, segunda, tercera, ninguna
}


#Preview {
    MainView()
}
