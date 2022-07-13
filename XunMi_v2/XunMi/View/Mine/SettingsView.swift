//
//  SettingsView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("uid") var uid: Int = -1
    @AppStorage("username") var username: String = ""
    @AppStorage("telphone") var telphone: String = ""
    
    @State var clearData: Bool = false
    @State var footprint: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.clear)
                    .ignoresSafeArea()
                
                Circle()
                    .frame(width: 400, height: 400, alignment: .center)
                    .foregroundColor(Color(red: 144/255.0, green: 177/255.0, blue: 249/255.0, opacity: 1.0))
                    .offset(x: metrics.size.width/4, y: -1*metrics.size.height/2)
                    .overlay {
                        Circle()
                            .fill(Color(red: 144/255.0, green: 177/255.0, blue: 249/255.0, opacity: 1.0))
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: metrics.size.width/4,y: metrics.size.height/2)
                    }
                
                Circle()
                    .fill(.blue)
//                    .frame(width: 500, height: 500, alignment: .center)
                    .opacity(0.8)
                    .offset(x: -250)
                    .clipped()
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(1)
                    .ignoresSafeArea()
                    .overlay {
                    }
                    .overlay {
                        VStack(alignment: .leading) {
                            NavigationLink{
                                AccountView()
                            } label: {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: metrics.size.width, height: 60, alignment: .center)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                    .overlay(alignment: .leading) {
                                        HStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 200, height: 200, alignment: .center)
                                                .opacity(0.8)
                                                .offset(x: -100)
                                            Spacer()
                                        }
                                    }
                                    .clipped()
                                    .overlay {
                                        Text("账户与安全")
                                            .foregroundColor(.black)
                                    }
                            }
                            .padding(.vertical, 10)
                            
                            Button {
                                footprint.toggle()
                            } label: {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: metrics.size.width, height: 60, alignment: .center)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                    .overlay(alignment: .leading) {
                                        HStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 200, height: 200, alignment: .center)
                                                .opacity(0.8)
                                                .offset(x: -100)
                                            Spacer()
                                        }
                                    }
                                    .clipped()
                                    .overlay {
                                        Text("足迹设置")
                                            .foregroundColor(.black)
                                    }
                            }
                            .alert(isPresented: $footprint) {
                                Alert(title: Text("正在开发中，敬请期待！"), dismissButton: .default(Text("确认")))
                            }
                            
                            NavigationLink{
                                AboutView()
                            } label: {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: metrics.size.width, height: 60, alignment: .center)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                    .overlay(alignment: .leading) {
                                        HStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 200, height: 200, alignment: .center)
                                                .opacity(0.8)
                                                .offset(x: -100)
                                            Spacer()
                                        }
                                    }
                                    .clipped()
                                    .overlay {
                                        Text("关于我们")
                                            .foregroundColor(.black)
                                    }
                            }
                            .padding(.vertical, 10)
                            
                            Button {
                                clearData.toggle()
                            } label: {
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: metrics.size.width, height: 60, alignment: .center)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                    .overlay(alignment: .leading) {
                                        HStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 200, height: 200, alignment: .center)
                                                .opacity(0.8)
                                                .offset(x: -100)
                                            Spacer()
                                        }
                                    }
                                    .clipped()
                                    .overlay {
                                        Text("清除缓存")
                                            .foregroundColor(.black)
                                    }
                            }
                            .alert("请确认是否清楚缓存", isPresented: $clearData) {
                                Button("确认", role: .destructive, action: {
                                    uid = -1
                                    username = ""
                                    telphone = ""
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                Button("取消", role: .cancel, action: {})
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.top, 30)
                        .offset(x: -25)
                        
                        if clearData || footprint {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                        }
                    }
                    .clipped()
                    .ignoresSafeArea()
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
