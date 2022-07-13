//
//  SignInView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var message = ""
    
    @AppStorage("uid") var saveUid: Int = -1
    @AppStorage("username") var saveUsername: String = ""
    @AppStorage("telphone") var saveTelphone: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.clear)
                    .ignoresSafeArea()
                
                Circle()
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
                    .opacity(0.8)
                    .offset(x: -250)
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                login
            }
            .clipped()
            .ignoresSafeArea()
            .navigationTitle("登陆")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var login: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                TextField("用户名", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            
            Divider()
            
            HStack {
                Image(systemName: "lock")
                if showPassword {
                    TextField("密码", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }else {
                    SecureField("密码", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                }
                .foregroundColor(.black)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            
            Divider()
            
            HStack {
                Spacer()
                Button("登陆") {
                    Sign.signIn(username: username, password: password) { result in
                        if result["code"] as! Int == 0 {
                            self.saveUid = result["uid"] as! Int
                            self.saveUsername = result["username"] as! String
                            self.saveTelphone = result["telphone"] as! String
                            message = "登陆成功"
                            self.presentationMode.wrappedValue.dismiss()
                        }else {
                            message = "请输入正确的账号密码"
                        }
                        showAlert.toggle()
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(message), dismissButton: .default(Text("确认")))
                }
                
                Spacer()
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("注册")
                }
                
                Spacer()
            }
            .padding()
        }
        .padding(.vertical, 30)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding()
        .shadow(color: .purple, radius: 1, x: 0, y: 0)
        .overlay(alignment: .bottomTrailing) {
            NavigationLink {
                ForgetView()
            } label: {
                Text("忘记密码")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .offset(x: -30, y: -30)
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
