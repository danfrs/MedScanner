//
//  MedicamentoRow.swift
//  MedScanner
//
//  Created by Dan Frimu on 10/11/24.
//

import SwiftUI

struct MedicamentoRow: View {
    let medicamento: Medicamento.Medicamento_Info
    var body: some View {
        HStack {
            Rectangle().frame(width: 10).foregroundColor(.yellow)
            VStack(alignment: .leading){
                Text(medicamento.nombre).bold().padding(5)
                Text(medicamento.labtitular).foregroundColor(.gray).offset(x: 15)
            }
            Spacer()
            
        }
    }
}

#Preview {
    MedicamentoRow(medicamento: Medicamento.Medicamento_Info(nregistro: "123456789", nombre: "Naproxeno", labtitular: "Laboratorios Cinfa S.A."))
}
