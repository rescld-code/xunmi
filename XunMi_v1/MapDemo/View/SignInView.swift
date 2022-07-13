//
//  SignIn.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/3.
//

import SwiftUI

struct SignInView: View {
    @Binding var username: String
    @Binding var uid: Int
    
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var message = ""
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var showBottomMenu: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .opacity(0.5)
                
            VStack {
                Group {
                    HStack {
                        Image(systemName: "person")
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    HStack {
                        Image(systemName: "lock")
                        if showPassword {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }else {
                            SecureField("Password", text: $password)
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
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                HStack {
                    Button("Log In") {
                        Sign.signIn(username: username, password: password) { result in
                            if result["code"] as! Int8 == 0 {
                                username = result["username"] as! String
                                uid = result["uid"] as! Int
                                
                                message = "登陆成功"
                                self.presentationMode.wrappedValue.dismiss()
                                showBottomMenu = true
                            }else {
                                message = "请输入正确的账号密码"
                            }
                            showAlert.toggle()
                        }
                    }
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(message), dismissButton: .default(Text("确认")))
                    }
                }
            }
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding()
            .shadow(color: .purple, radius: 1, x: 0, y: 0)
            .overlay(alignment: .bottomTrailing) {
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .font(.footnote)
                        .offset(x: -30, y: 10)
                        .foregroundColor(.black)
                        .opacity(0.5)
                }
                .buttonStyle(.plain)
            }
        }
        .background(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
        .onAppear {
            showBottomMenu = false
            username = ""
        }
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    username = "Username"
                    showBottomMenu = true
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("About")
                    }
                }

            }
        }
    }
    
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(username: .constant(""), uid: .constant(1), showBottomMenu: .constant(false))
    }
}
