//
//  ForgetView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/10.
//

import SwiftUI

struct ForgetView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var telphone: String = ""
    @State private var captcha: String = ""
    
    @State private var register: String = String(arc4random() % 9000 + 1000)
    
    @State private var delay: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var alert: Bool = false
    @State private var message: String = ""
    
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
                
                forget
            }
            .clipped()
            .onAppear {
                self.delay = 0
            }
            .onReceive(timer) { time in
                if self.delay > 0 {
                    self.delay -= 1
                }
            }
            .ignoresSafeArea()
            .navigationTitle("忘记密码")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var forget: some View {
            VStack {
                HStack {
                    Image(systemName: "phone")
                    TextField("手机号", text: $telphone)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                
                Divider()
                
                HStack {
                    Text("验证码: ")
                    TextField("", text: $captcha)
                    if self.delay == 0 {
                        Button {
                            if Verify.isPhoneNumber(phoneNumber: telphone) {
                                register = String(arc4random() % 9000 + 1000)
                                Sign.sms(tel: telphone, captcha: register) { result in
                                    if result["code"] as! Int == 0 {
                                        message = "发送成功"
                                    }else {
                                        message = "发送失败"
                                    }
                                    alert.toggle()
                                }
                                self.delay = 60
                            }else {
                                message = "请输入正确的手机号码"
                                alert.toggle()
                            }
                        } label: {
                            Text("获取验证码")
                        }
                        .alert(isPresented: $alert) {
                            Alert(title: Text(message), dismissButton: .default(Text("确认")))
                        }
                    } else {
                        Text("\(self.delay)")
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                
                Divider()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("新密码", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                
                Divider()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("确认密码", text: $confirm)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                
                Button {
                    if !telphone.isEmpty && !captcha.isEmpty && !password.isEmpty && !confirm.isEmpty {
                        if password == confirm && captcha == register {
                            Sign.forget(telphone: telphone, password: password) { result in
                                if result["code"] as! Int == 0 {
                                    message = "重置成功"
                                    alert.toggle()
                                    presentationMode.wrappedValue.dismiss()
                                }else {
                                    message = "重置失败"
                                    alert.toggle()
                                }
                            }
                        }else {
                            message = "请正确输入信息"
                            alert.toggle()
                        }
                    }else {
                        message = "请正确输入信息"
                        alert.toggle()
                    }
                } label: {
                    Text("重置密码")
                }
                .alert(isPresented: $alert, content: {
                    Alert(title: Text(message), dismissButton: .default(Text("确认")))
                })
                .padding()
            }
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding()
            .shadow(color: .purple, radius: 1, x: 0, y: 0)
    }
}

struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView()
    }
}
