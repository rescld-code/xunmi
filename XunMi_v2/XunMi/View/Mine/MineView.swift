//
//  MineView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct MineView: View {
    
    @State var username: String = ""
    
    @AppStorage("uid") var uid: Int = -1
    @AppStorage("username") var saveUsername: String = "Username"
    
    var body: some View {
        GeometryReader { metrics in
            
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: metrics.size.width*0.9, height: 270, alignment: .center)
                        .overlay {
                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                .font(.system(size: 52))
                                .foregroundStyle(.blue, .blue.opacity(0.3))
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(Circle().fill(.ultraThinMaterial))
                                .background(
                                    Image(systemName: "hexagon")
                                        .symbolVariant(.fill)
                                        .foregroundColor(.blue)
                                        .font(.system(size: 200))
                                        .offset(x: -50, y: -120)
                                )
                        }
                        .overlay(alignment: .bottom) {
                            if uid == -1 {
                                NavigationLink {
                                    SignInView()
                                } label: {
                                    Text("未登陆")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .padding(.bottom, 35)
                            }else {
                                Text(saveUsername)
                                    .font(.title)
                                    .padding(.bottom, 35)
                            }
                        }
                    
                    ScrollView {
                        list
                            .padding(.vertical, 30)
                    }
                    
                    Spacer()
                }
                .clipped()
            }
            .navigationTitle("我的")
        }
        .onAppear {
            username = saveUsername
        }
    }
    
    var list: some View {
        VStack {
            NavigationLink {
                SettingsView()
            }label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 3)
                    .shadow(color: Color(.systemGray3), radius: 3, x: 0, y: 0)
                    .overlay(alignment: .leading) {
                        HStack {
                            Image(systemName: "gear")
                            Text("设置")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 50)
                    }
            }
            NavigationLink {
                FootprintView()
            }label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 3)
                    .shadow(color: Color(.systemGray3), radius: 3, x: 0, y: 0)
                    .overlay(alignment: .leading) {
                        HStack {
                            Image(systemName: "pawprint")
                            Text("足迹")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 50)
                    }
            }
            NavigationLink {
                MessageView()
            }label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 3)
                    .shadow(color: Color(.systemGray3), radius: 3, x: 0, y: 0)
                    .overlay(alignment: .leading) {
                        HStack {
                            Image(systemName: "envelope")
                            Text("消息通知")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 50)
                    }
            }
            NavigationLink {
                ServiceView()
            }label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(height: 50, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 3)
                    .shadow(color: Color(.systemGray3), radius: 3, x: 0, y: 0)
                    .overlay(alignment: .leading) {
                        HStack {
                            Image(systemName: "camera.filters")
                            Text("服务中心")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 50)
                    }
            }
        }
    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView()
        MineView()
            .preferredColorScheme(.dark)
    }
}
