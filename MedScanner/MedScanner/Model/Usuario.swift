//
//  User.swift
//  MedScanner
//
//  Created by Dan Frimu on 4/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Usuario : ObservableObject{

    struct UsuarioStruct : Identifiable, Codable{
        let id: String
        let nombre: String
        let apellidos: String
        let email: String
    }

}
