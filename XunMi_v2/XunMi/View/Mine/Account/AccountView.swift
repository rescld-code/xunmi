//
//  AccountView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct AccountView: View {
    @State private var exit: Bool = false
    
    @AppStorage("uid") var uid: Int = -1
    @AppStorage("username") var username: String = ""
    @AppStorage("telphone") var telphone: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        NavigationLink {
                            UsernameView()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                                .overlay {
                                    HStack {
                                        Text("用户昵称")
                                            .padding(.leading, 20)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .padding(.trailing, 20)
                                    }
                                    .foregroundColor(.black)
                                }
                        }
                        
                        NavigationLink {
                            PhoneView()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                                .overlay {
                                    HStack {
                                        Text("手机号码")
                                            .padding(.leading, 20)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .padding(.trailing, 20)
                                    }
                                    .foregroundColor(.black)
                                }
                        }
                        
                        NavigationLink {
                            PasswordView()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                                .overlay {
                                    HStack {
                                        Text("修改密码")
                                            .padding(.leading, 20)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .padding(.trailing, 20)
                                    }
                                    .foregroundColor(.black)
                                }
                        }
                        
                        Button {
                            exit.toggle()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                                .overlay {
                                    HStack {
                                        Text("退出登录")
                                            .padding(.leading, 20)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .padding(.trailing, 20)
                                    }
                                    .foregroundColor(.black)
                                }
                        }
                        .alert("请确认是否退出登录", isPresented: $exit) {
                            Button("确认", role: .destructive, action: {
                                uid = -1
                                username = ""
                                telphone = ""
                                self.presentationMode.wrappedValue.dismiss()
                            })
                            Button("取消", role: .cancel, action: {})
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                }
            }
            .navigationTitle("账户与安全")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
