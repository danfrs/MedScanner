//
//  Autenticacion.swift
//  MedScanner
//
//  Created by Dan Frimu on 4/12/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class Autenticacion: ObservableObject {
    
    @Published var sesion: FirebaseAuth.User?
    @Published var usuario: Usuario.UsuarioStruct?
    
    init(){
        self.sesion = Auth.auth().currentUser
        Task {
            await getDatosUsuario()
           // print("SESION \(self.sesion)")
        }
    }
    
    func crearUsuario(withEmail email: String, password: String, nombre: String, apellidos: String) async throws -> String{
        var errorMsg = ""
        do{
            let resultado = try await FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password)
            self.sesion = resultado.user
            let usuario = Usuario.UsuarioStruct(id: resultado.user.uid, nombre: nombre, apellidos: apellidos, email: email)
            let usarioCodificadoJson = try Firestore.Encoder().encode(usuario)
            try await Firestore.firestore().collection("usuarios").document(usuario.id).setData(usarioCodificadoJson)
            await getDatosUsuario()
        }catch{
            print("Error: \(error.localizedDescription)")
            errorMsg = error.localizedDescription
        }
        return errorMsg
    }
    
    func login(withEmail email: String, password: String) async throws -> String {
        var errorMsg = ""
        do{
            let resultado = try await Auth.auth().signIn(withEmail: email, password: password)
            self.sesion = resultado.user
            await getDatosUsuario()
            //errorMsg = "Login Correcto"
        } catch {
            errorMsg = error.localizedDescription
            print("Error login: \(error.localizedDescription)")
            
        }
        return errorMsg
    }
    
    func logout() async throws {
        do{
            try Auth.auth().signOut()
            self.sesion = nil
            self.usuario = nil
            
        }
        print("logout")
    }
    
    func getDatosUsuario() async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("usuarios").document(uid).getDocument() else {return}
        print("Auth.auth().currentUser?.uid : \(snapshot)")
        self.usuario = try? snapshot.data(as: Usuario.UsuarioStruct.self)
        //print("Get Usuario : \(snapshot)")
    }
    
}
