//
//  MapView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/2.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var locationViewModel = LocationModel()
    @State var hiddenSearch = true
    @State var inputContent = ""
    @State var text: String = ""
    @Binding var putPills: Bool
    
    var body: some View {
        GeometryReader { metrics in
            
            Map(coordinateRegion: $locationViewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemBlue))
                .onAppear {
                    locationViewModel.checkIfServiceIsEnable()
                }
                .overlay {
                    if hiddenSearch {
                        Button(action: {
                            hiddenSearch.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .padding(10)
                        })
                        .background(.white)
                        .cornerRadius(10)
                        .offset(x: metrics.size.width/2-30, y: -1*metrics.size.height/2 + 50)
                    } else {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Placeholder", text: $inputContent)
                            Button {
                                if inputContent == "" {
                                    hiddenSearch.toggle()
                                }else {
                                    inputContent = ""
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(10)
                        .background(.white)
                        .cornerRadius(10)
                        .frame(width: metrics.size.width * 0.9, height: 30, alignment: .center)
                        .offset(y: -1*metrics.size.height/2 + 50)
                    }
                    
                    Button(action: {
                        putPills.toggle()
                    }, label: {
                        Image(systemName: putPills ? "xmark" : "plus")
                            .padding(10)
                    })
                    .background(.white)
                    .cornerRadius(10)
                    .offset(x: metrics.size.width/2-30, y: -1*metrics.size.height/2 + 100)
                    
                    Button(action: {
                        locationViewModel.checkedLocationAuthorization()
                    }, label: {
                        Image(systemName: "o.circle")
                            .padding(10)
                    })
                    .background(.white)
                    .cornerRadius(10)
                    .offset(x: metrics.size.width/2-30, y: -1*metrics.size.height/2 + 150)
                    
                }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(putPills: .constant(false))
    }
}
