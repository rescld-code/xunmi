//
//  ContentView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/6.
//

import SwiftUI
import MapKit

// 地图注释模型
struct IdentifiablePlace: Identifiable {
    let id: Int
    let location: CLLocationCoordinate2D
    let theme: String
    init(id: Int, lat: Double, long: Double, image: String) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        self.theme = image
    }
}

struct ContentView: View {
    
    // 显示区域
    @State var region: MKCoordinateRegion = MKCoordinateRegion()
    // 位置处理对象
    let locationTool = LocationTool()
    // 注释信息
    @State var annotationPlace: [IdentifiablePlace] = []
    // 搜索信息
    @State var searchAddress: String = ""
    
    @State var showDetail: Bool = false
    
    @State var uid: Int = -1
    @State var pillsId: Int = 0
    @AppStorage("uid") var saveUid: Int = -1
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Body视图
    var body: some View {
        NavigationView {
            GeometryReader { metrics in
                ZStack {
                    MapView(showDetail: $showDetail, pillsId: $pillsId, region: $region, annotationPlace: $annotationPlace)
                        .overlay {
                            NavigationLink {
                                if uid == -1 {
                                    SignInView()
                                }else {
                                    PillsFormView()
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .padding(10)
                            }
                            
                            .background(.white)
                            .cornerRadius(10)
                            .offset(x: metrics.size.width/2 - 30, y: metrics.size.height/2-50)
                            
                            Button(action: {
                                region = MKCoordinateRegion(center: locationTool.locationManager.location!.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                            }, label: {
                                Image(systemName: "paperplane")
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .padding(10)
                            })
                            .background(.white)
                            .cornerRadius(10)
                            .offset(x: metrics.size.width/2 - 30, y: metrics.size.height/2-100)
                        }
                        .onAppear {
                            self.uid = saveUid
                            Pills.GetAllPills { result in
                                guard let pills = result["pills"] as? [[String: Any]] else {
                                    return
                                }
                                annotationPlace = []
                                for item in pills {
                                    annotationPlace.append(IdentifiablePlace(id: item["ID"] as! Int, lat: item["Latitude"] as! Double, long: item["Longitude"] as! Double, image: item["Theme"] as! String))
                                }
                            }
                        }
                    
                    if showDetail {
                        PillsDetail(show: $showDetail, id: $pillsId)
                    }
                }
            }
        }
        .searchable(text: $searchAddress)
        .onSubmit(of: .search) {
            if !searchAddress.isEmpty {
                locationTool.geocoderAddress(searchAddress) { coordinate in
                    // 更改地图显示区域：当前位置方圆500米
                    region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
