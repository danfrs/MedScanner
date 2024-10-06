//
//  Registro.swift
//  MedScanner
//
//  Created by Dan Frimu on 7/11/24.
//

import SwiftUI

struct Registro: View {
    @EnvironmentObject var autenticacion: Autenticacion
    @State private var email = ""
    @State private var password = ""
    @State private var reppassword = ""
    @State private var nombre = ""
    @State private var apellidos = ""
    @State var errormsg = ""
    
    var body: some View {
            ZStack{
                Text("Registro").font(.system(size: 30, weight: .bold, design: .rounded )).offset(x: 0, y: -290)
                Image("applogo").resizable().frame(width: 90, height: 90).offset(x:0, y: -220)
                VStack{
                    TextField("Nombre", text: $nombre).foregroundColor(.black)
                        .textFieldStyle(.plain).padding(10).autocorrectionDisabled()
                    Divider()
                    TextField("Apellidos", text: $apellidos).foregroundColor(.black)
                        .textFieldStyle(.plain).padding(10).autocorrectionDisabled()
                    Divider()
                    TextField("Email", text: $email).foregroundColor(.black)
                        .textFieldStyle(.plain).padding(10).autocorrectionDisabled().autocapitalization(.none)
                    Divider()
                    SecureField("Contraseña", text: $password).foregroundColor(.black)
                        .textFieldStyle(.plain).padding(10).autocorrectionDisabled().autocapitalization(.none)
                    Divider()
                   /* TextField("Repetir Contraseña", text: $reppassword).foregroundColor(.black)
                        .textFieldStyle(.plain).padding(10)
                    */
                    Button {
                        //  Registrar
                        Task{
                           let result = try await autenticacion.crearUsuario(withEmail: email, password: password, nombre: nombre, apellidos: apellidos)
                            errormsg = result
                        }
                    } label: {
                        Text("Registrarme").bold().frame(width: 250, height: 50).background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))).foregroundColor(.white)
                    }
                    .padding(.top)
                    Text(errormsg).foregroundColor(.red).padding(.top)
                    }

            }.padding()
        }
}



#Preview {
    Registro()
}
