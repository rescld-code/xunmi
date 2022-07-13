//
//  SignUpView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/3.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                        SecureField("Password", text: $password)
                    }
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Confirm", text: $confirm)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                HStack {
                    Button("Sign Up") {
                        if username == "" || password == "" || confirm == "" {
                            message = "请正确输入信息"
                            showAlert.toggle()
                        }else if password != confirm {
                            message = "请正确输入信息"
                            showAlert.toggle()
                        }else {
                            Sign.signUp(username: username, password: password) { result in
                                if result["code"] as! Int8 == 0 {
                                    message = "注册成功"
                                    self.presentationMode.wrappedValue.dismiss()
                                }else {
                                    message = "注册失败"
                                }
                                showAlert.toggle()
                            }
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
        }
        .background(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Sign In")
                    }
                }

            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
