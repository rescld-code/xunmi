//
//  PillsForm.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/3.
//

import SwiftUI
import MapKit

struct PillsForm: View {
    @State private var color: Color = .red
    
    @State private var text: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var showAlert: Bool = false
    @State private var message: String = ""
    
    @Binding var putPills: Bool
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                    .opacity(0.9)
                    .overlay {
                        List {
                            Section {
                                HStack {
                                    ColorPicker("Color:", selection: $color)
                                }
                                HStack {
                                    Text("Latitude: ")
                                    TextField("latitude", value: $latitude, format: .number)
                                }
                                HStack {
                                    Text("Longitude: ")
                                    TextField("longitude", value: $longitude, format: .number)
                                }
                                HStack {
                                    Text("Text: ")
                                    TextField("Text", text: $text)
                                }
                            }
                            
                            Section {
                                Button("Submit") {
                                    Pills.putPills(latitude: latitude, longitude: longitude, text: text) { result in
                                        if result["code"] as! Int == 0 {
                                            latitude = 0
                                            longitude = 0
                                            text = ""
                                            message = "投掷成功"
                                            putPills.toggle()
                                        }else {
                                            message = "投掷失败"
                                        }
                                        showAlert.toggle()
                                    }
                                }.alert(isPresented: $showAlert) {
                                    Alert(title: Text(message), dismissButton: .default(Text("确认")))
                                }
                                
                                Button("Cancel") {
                                    putPills.toggle()
                                }
                                .foregroundColor(.red)
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
            }
            .frame(height: metrics.size.height/2, alignment: .center)
        }
    }
}

struct PillsForm_Previews: PreviewProvider {
    static var previews: some View {
        PillsForm(putPills: .constant(false))
    }
}
