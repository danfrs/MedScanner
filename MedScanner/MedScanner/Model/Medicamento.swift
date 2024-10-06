//
//  Medicamento.swift
//  MedScanner
//
//  Created by Dan Frimu on 4/11/24.
//

import Foundation
import FirebaseFirestore

class Medicamento{
    
    struct ReturnedJson:Codable {
        let totalFilas: Int
        let resultados :[Medicamento_Info]
    }
    
    struct RetuernedDetails:Codable {
        let nregistro: String
        let nombre: String
        let labtitular: String
        let docs: [Docs]
        let viasAdministracion: [ViaAdministracion]
        let fotos: [Fotos]
        let dosis: String
        let cpresc: String
    }
    
    struct ReturnedRecomendaciones: Codable {
        let results: [Recomendacionesresult]
    }
    
    struct Recomendacionesresult: Codable {
        let seccion: String
        let titulo: String
        let content: String
    }
    
    struct Medicamento_Info:Codable, Identifiable {
        let nregistro: String
        let nombre: String
        let labtitular: String
        // Al no devolver la api una clave id numerico unico
        // para cada registro, en cambio este es el
        // nregistro, por lo que hay que indicar
        // cual es identificador que se utiliza en la struct
        var id: String { // Identificador unico
              return nregistro
        }
    }

    struct ViaAdministracion: Codable {
        let id: Int
        let nombre: String
    }
    
    struct Docs: Codable {
        let tipo: Int
        let urlHtml: String
    }
    
    struct Fotos: Codable {
        let tipo: String
        let url: String
    }
    
    func getMedicamentosUrl(texto:String) async throws -> ReturnedJson {
        let url = URL(string: "https://cima.aemps.es/cima/rest/medicamentos?nombre=\(texto)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONDecoder().decode(ReturnedJson.self, from: data)
        return json
    }
    
    func getMedicamentoByNRegistro(nregistro: String) async throws -> RetuernedDetails {
        let url = URL(string: "https://cima.aemps.es/cima/rest/medicamento?nregistro=\(nregistro)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONDecoder().decode(RetuernedDetails.self, from: data)
        return json
    }
    
    func getRecomendacionesMedicamentoByNRegistro(nregistro: String) async throws -> ReturnedRecomendaciones {
        let url = URL(string: "https://cima.aemps.es/cima/rest/docSegmentado/contenido/2?nregistro=\(nregistro)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONDecoder().decode(ReturnedRecomendaciones.self, from: data)
        return json
    }
    
    /*
    func insertBusquedaReciente(userid: String, nregistro: String, date: Date, nombre: String, laboratorio: String) async {
        
        let insertarBusqueda = try await Firestore.firestore().collection("medicamento-usuario").addDocument(data: [
            "userid": auth.getUserID() ?? "",
            "nregistro": nregistro,
            "date": currentdate,
            "nombre": medicamento?.nombre ?? "",
            "laboratorio": medicamento?.labtitular ?? ""
        ])
        print(insertarBusqueda)
    }
    */
}
