//
//  Medicamento_Desc.swift
//  MedScanner
//
//  Created by Dan Frimu on 10/11/24.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Medicamento_Desc: View {
    let nregistro: String
    @State var medicamento:Medicamento.RetuernedDetails? = nil
    @State var recomendaciones:Medicamento.ReturnedRecomendaciones? = nil
    @EnvironmentObject var autenticacion: Autenticacion
    @State var cargando:Bool = true
    @Environment(\.openURL) private var openURL
    let auth = Auth.auth()
    let db = Firestore.firestore()
    let currentdate = Date()
    
    var body: some View {
        VStack {
            if cargando{
                ProgressView().tint(.white)
            }else if let medicamento = medicamento {
            Text("Detalles").font(.title).bold().frame(maxWidth: .infinity, alignment: .leading).padding()
                WebImage(url: URL(string: medicamento.fotos.first!.url)).resizable().scaledToFit().scaledToFill().frame(width: 80, height: 80).padding().clipShape(Circle()).overlay(Circle().stroke(Color.blue, lineWidth: 2))
                Text(medicamento.nombre).font(.title3).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding()
            Button {
                // Ver prospecto
                if let url = URL(string: medicamento.docs.first!.urlHtml) {
                                openURL(url)
                            }
            } label: {
                Text("Ver prospecto").bold().frame(width: 180, height: 40).background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.black], startPoint: .top, endPoint: .bottomTrailing))).foregroundColor(.white)
            }
            //Divider().padding().frame(width: 350)
            Text("Datos").foregroundColor(.blue).padding()
            Divider().overlay(.blue).frame(width: 320)
          VStack{
              Label("Laboratorio", systemImage: "building")
              Text(medicamento.labtitular).foregroundColor(.gray)
              Label("Dosis", systemImage: "pills")
              Text(medicamento.dosis).foregroundColor(.gray)
              Label("Receta", systemImage: "ticket")
              Text(medicamento.cpresc).foregroundColor(.gray)
              Label("Via de Administración", systemImage: "info.square")
              Text(medicamento.viasAdministracion.first!.nombre).foregroundColor(.gray)
              Label("Nº Regidstro", systemImage: "tray")
              Text(medicamento.nregistro).foregroundColor(.gray)
          }.padding(20)
                /*
            Text("Instrucciones").foregroundColor(.purple)
            Divider().overlay(.purple).frame(width: 320)
            VStack{
                Label("Antes de tomar Naproxeno Sódico", systemImage: "questionmark.bubble")
                Text("- Si es alérgico al naproxeno o naproxeno sódico o a alguno de los demás componentes de este medicamento.").foregroundColor(.gray)
            }.padding(10)
                */
            }
            Spacer()
        }.onAppear{
            Task{
                do{
                    medicamento = try await Medicamento().getMedicamentoByNRegistro(nregistro: nregistro)
                    //recomendaciones = try await Medicamento().getRecomendacionesMedicamentoByNRegistro(nregistro: nregistro)
                }catch{
                    print(error)
                    medicamento = nil
                }
                cargando = false
                if medicamento != nil{
                    do{
                        // Insertar datos en búsquedas recientes
                  //  await Medicamento().insertBusquedaReciente(userid: autenticacion.usuario?.id ?? "" , nregistro: medicamento?.nregistro ??  "", date: currentdate, nombre: medicamento?.nombre ??  "" , laboratorio: medicamento?.labtitular ??  "")
                       
                        let insertData =  try await db.collection("medicamento-usuario").addDocument(data: [
                                  "userid": auth.getUserID() ?? "",
                                  "nregistro": nregistro,
                                  "date": currentdate,
                                  "nombre": medicamento?.nombre ?? "",
                                  "laboratorio": medicamento?.labtitular ?? ""
                              ])
                              print(insertData)
                    }
                }
            }

        }
    }
}

#Preview {
    Medicamento_Desc(nregistro:"65730").environmentObject(Autenticacion())
}
