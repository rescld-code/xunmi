//
//  ContentView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/6/30.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationViewModel = LocationModel()
    
    @State var selectedPage = 0
    @State var putPills = false
    @State var showMenu = true
    
    @State var username: String = "Login"
    @State var uid: Int = -1
    
    var body: some View {
        NavigationView {
            GeometryReader { metrics in
                ZStack {
                    if selectedPage == 0 {
                        MapView(putPills: $putPills)
                        if putPills {
                            PillsForm(putPills: $putPills)
                                .zIndex(1)
                                .offset(y: metrics.size.height/2)
                        }
                    }else if selectedPage == 1 {
                        AboutView(username: $username, uid: $uid, showMenu: $showMenu)
                    }
                    
                    if showMenu {
                        menu
                            .frame(width: metrics.size.width * 0.9, height: 44, alignment: .center)
                            .background(.white)
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 10, x: 3, y: 3)
                            .offset(y: metrics.size.height/2 - 44)
                    }
                }
                .navigationBarHidden(true)
            }
        }
        .ignoresSafeArea()
    }
    
    var menu: some View {
        HStack {
            Spacer()
            Button {
                selectedPage = 0
            } label: {
                ZStack {
                    Image(systemName: "capsule")
                        .resizable()
                        .frame(width: 18, height: 9, alignment: .center)
                        .rotationEffect(.degrees(-45))
                        .foregroundColor(.blue)
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: 8, height: 1, alignment: .center)
                        .rotationEffect(.degrees(45))
                        .foregroundColor(.blue)
                    if selectedPage == 0 {
                        Circle()
                            .frame(width: 35, height:35, alignment: .center)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .zIndex(-99)
                    }
                }
            }
            
            Spacer()
            
            Button {
                selectedPage = 1
            } label: {
                Image(systemName: "person")
                    .overlay {
                        if selectedPage == 1 {
                            Circle()
                                .frame(width: 35, height:35, alignment: .center)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                                .zIndex(-99)
                        }
                    }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
