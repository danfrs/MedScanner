//
//  User.swift
//  MedScanner
//
//  Created by Dan Frimu on 4/11/24.
//

import Foundation

struct Usuario : Identifiable, Codable{
        let id: String
        let nombre: String
        let apellidos: String
        let email: String
}
