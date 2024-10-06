//
//  Login.swift
//  MedScanner
//
//  Created by Dan Frimu on 5/11/24.
//

import SwiftUI
struct Login: View {
    @EnvironmentObject var autenticacion: Autenticacion
    @State private var email = ""
    @State private var password = ""
    @State var errormsg = ""
    
    var body: some View{            
        NavigationView{
            ZStack{
                Text("Bienvenido").font(.system(size: 40, weight: .bold, design: .rounded )).offset(x: 0, y: -280)
                Image("applogo").resizable().frame(width: 120, height: 120).offset(x:0, y: -180)
                VStack{
                    TextField("Email", text: $email).keyboardType(.emailAddress).autocapitalization(.none).padding(20)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                    // .OnChange Si hay error, cambiar a rojo el borde
                    SecureField("Contraseña", text: $password).padding(20)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                    Button {
                        // Login
                        Task{
                            let result = try await autenticacion.login(withEmail: email, password: password)
                            errormsg = result
                        }
                    } label: {
                        Text("Continuar").bold().frame(width: 250, height: 50).background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))).foregroundColor(.white)
                    }
                    .padding(.top).offset(y: 10)
                    
            
                }
                NavigationLink(
                    destination: Registro(),
                    label: {
                        Text("Nuevo usuario? Crear una cuenta").bold()
                    }
                )
                .frame(maxWidth: .infinity)
                .offset(y: 150)
                
                Text(errormsg).foregroundColor(.red).padding(.top).offset(y: 200)
            }.padding()
        }
    }
    
}

#Preview {
    Login()
}
