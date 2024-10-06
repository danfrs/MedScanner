//
//  CameraView.swift
//  MedScanner
//
//  Created by Dan Frimu on 8/12/24.
//

import SwiftUI
import Vision

struct CameraView: View {
    @State private var fotoCamara: UIImage?
    @State private var textosImagen = [String]()
    @State private var bCargando = false

    func reconocerTexto()
    {
        
    }
    
    var body: some View {
        VStack
        {
            if (self.fotoCamara == nil){
              //  CameraView(image: self.fotoCamara)
            }else {
                if(self.bCargando){
                    
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
