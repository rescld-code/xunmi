//
//  MapView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/6.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    let locationTool = LocationTool()
    let regionTool = RegionMonitoringTool()
    
    @Binding var showDetail: Bool
    @Binding var pillsId: Int
    @Binding var region: MKCoordinateRegion
    @Binding var annotationPlace: [IdentifiablePlace]
    
    @State var showAlert: Bool = false
    
    @AppStorage("uid") var uid: Int = -1
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: annotationPlace) { place in
            MapAnnotation(coordinate: place.location) {
                Button {
                    // 不支持区域监测
                    guard regionTool.regionAvaiable() else {
                        return
                    }
                    // 设定监测的区域
                    let region = CLCircularRegion(center: place.location, radius: 200, identifier: "company")
                    if region.contains(locationTool.locationManager.location!.coordinate)  {
                        pillsId = place.id
                        showDetail.toggle()
                    }else {
                        showAlert.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                        .overlay {
                            Image(place.theme)
                                .resizable()
                                .shadow(color: .blue, radius: 3, x: 0, y: 0)
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("不在范围内"), dismissButton: .default(Text("确认")))
                })
                .foregroundColor(.clear)
                .cornerRadius(20)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("寻觅")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard locationTool.locationServiceAvaiable() else {
                print("不支持位置服务")
                return
            }
            locationTool.requestAuthorization()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    NavigationLink {
                        if uid == -1 {
                            SignInView()
                        }else {
                            MineView()
                        }
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(showDetail: .constant(false), pillsId: .constant(0), region: .constant(MKCoordinateRegion()), annotationPlace: .constant([IdentifiablePlace(id: 0, lat: 0, long: 0, image: "Pills2")]))
    }
}
