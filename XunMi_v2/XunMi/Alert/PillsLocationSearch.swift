//
//  PillsLocationSearch.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import SwiftUI

struct PillsLocationSearch: View {
    
    let locationTool = LocationTool()
    
    @Binding var text: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    @Binding var show: Bool
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 10/255, green: 149/255, blue: 255/255, opacity: 1.0))
                    .frame(width: metrics.size.width * 0.8, height: 250, alignment: .center)
                    .shadow(color: .cyan, radius: 5, x: 0, y: 0)
                    .overlay {
                        VStack {
                            Text("位置")
                                .font(.title)
                                .foregroundColor(.white)
                            TextField("请输入地点名称", text: $text)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .onSubmit {
                                    if !text.isEmpty {
                                        locationTool.geocoderAddress(text) { coordinate in
                                            latitude = coordinate.latitude
                                            longitude = coordinate.longitude
                                        }
                                    }
                                }
                            Group {
                                Text("经度: \(latitude)")
                                Text("纬度: \(longitude)")
                            }
                            Button {
                                locationTool.geocoderAddress(text) { coordinate in
                                    latitude = coordinate.latitude
                                    longitude = coordinate.longitude
                                }
                                show.toggle()
                            } label: {
                                Rectangle()
                                    .fill(.ultraThickMaterial)
                                    .cornerRadius(10)
                                    .overlay {
                                        Text("确认")
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 80, height: 40, alignment: .center)
                            }
                        }
                }
            }
        }
    }
}

struct PillsLocationSearch_Previews: PreviewProvider {
    static var previews: some View {
        PillsLocationSearch(text: .constant("sss"), latitude: .constant(0.0), longitude: .constant(0.0), show: .constant(false))
    }
}
