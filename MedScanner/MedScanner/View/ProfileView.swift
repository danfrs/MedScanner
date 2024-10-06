//
//  User.swift
//  MedScanner
//
//  Created by Dan Frimu on 23/11/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @EnvironmentObject var autenticacion: Autenticacion
    var body: some View {
        if let usuario = autenticacion.usuario{
            VStack{
                Text("Perfil").font(.title).bold().frame(maxWidth: .infinity, alignment: .leading).padding()
                Text("\(usuario.nombre.first!)" + "\(usuario.apellidos.first!)").font(.title).bold().frame(maxWidth: .infinity).padding()
                    .frame(width: 80, height: 80).padding().clipShape(Circle()).overlay(Circle().stroke(Color.blue, lineWidth: 2))
                Text("\(usuario.nombre) " + "\(usuario.apellidos)").font(.title).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding()
                Text("Nombre: \(usuario.nombre)").foregroundColor(.black)
                    .textFieldStyle(.plain).padding(10)
                Divider()
                Text("Apellidos: \(usuario.apellidos)").foregroundColor(.black)
                    .textFieldStyle(.plain).padding(10)
                Divider()
                Text("Email: \(usuario.email)").foregroundColor(.black)
                    .textFieldStyle(.plain).padding(10)
                Divider()
                Spacer()
                VStack{
                    Button {
                        Task{
                            try await autenticacion.logout()
                        }
                    } label: {
                        Text("Cerrar Sesión").bold().frame(width: 250, height: 50).background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))).foregroundColor(.white)
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(Autenticacion())
}

