//
//  PasswordView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct PasswordView: View {
    @AppStorage("uid") var uid = -1
    @AppStorage("username") var username = "Username"
    
    @State var password = ""
    @State var newPassword = ""
    @State var confirm = ""
    
    @State var alert: Bool = false
    @State var message: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Group {
                        HStack {
                            Text("用户名：")
                            //                            .foregroundColor(.gray)
                                .frame(width: 80, alignment: .leading)
                            Text(username)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                        HStack {
                            Text("原密码: ")
                                .frame(width: 80, alignment: .leading)
                            SecureField("", text: $password)
                        }
                        
                        HStack {
                            Text("新密码: ")
                                .frame(width: 80, alignment: .leading)
                            SecureField("", text: $newPassword)
                        }
                        
                        HStack {
                            Text("确认密码: ")
                                .frame(width: 80, alignment: .leading)
                            SecureField("", text: $confirm)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("忘记密码")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                    
                    Button {
                        if !password.isEmpty && !newPassword.isEmpty && !confirm.isEmpty && newPassword == confirm {
                            UserAttribute.ChangePassword(uid: uid, password: password, newPassword: newPassword) { result in
                                if result["code"] as! Int == 0 {
                                    message = "修改成功"
                                    alert.toggle()
                                    presentationMode.wrappedValue.dismiss()
                                }else {
                                    message = "修改失败"
                                    alert.toggle()
                                }
                            }
                        } else {
                            password = ""
                            newPassword = ""
                            confirm = ""
                            message = "请正确输入信息"
                            alert.toggle()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 150, height: 50, alignment: .center)
                            .padding(.vertical, 10)
                            .overlay {
                                Text("确认修改")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                    .alert(isPresented: $alert) {
                        Alert(title: Text(message), dismissButton: .default(Text("确认")))
                    }
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal, 10)
            }
        }
        .navigationTitle("修改密码")
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
