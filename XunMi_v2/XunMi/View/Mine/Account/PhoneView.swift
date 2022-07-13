//
//  PhoneView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct PhoneView: View {
    
    @State var telphone: String = ""
    @State var change: Bool = false
    
    @State private var captcha: String = ""
    @State private var register: String = String(arc4random() % 9000 + 1000)
    
    @State private var changed: Bool = false
    @State private var alert: Bool = false
    @State private var message: String = ""
    
    @State private var delay: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @AppStorage("uid") var saveUid: Int = -1
    @AppStorage("telphone") var saveTel: String = ""
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .background(LinearGradient(colors: [Color(red: 49/255, green: 209/255, blue: 255/255),
                                                            Color(red: 41/255, green: 121/255, blue: 255/255, opacity: 1)],
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                        .padding(.bottom, 50)
                    
                    if change {
                        HStack {
                            Text("手机号码:")
                                .font(.title)
                            TextField(telphone, text: $telphone)
                                .font(.title)
                                .background(.white)
                                .opacity(0.8)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        }
                        .frame(width: metrics.size.width*0.8, height: 50, alignment: .center)
                        
                        HStack {
                            Text("验证码: ")
                            TextField("", text: $captcha)
                                .font(.title)
                                .background(.white)
                                .opacity(0.8)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 1, x: 0, y: 0)
                                .frame(width: metrics.size.width*0.3)
                            Spacer()
                            if self.delay == 0 {
                                Button {
                                    if Verify.isPhoneNumber(phoneNumber: telphone) {
                                        register = String(arc4random() % 9000 + 1000)
                                        Sign.sms(tel: telphone, captcha: register) { _ in }
                                        self.delay = 60
                                    }else {
                                        telphone = ""
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
                        .frame(width: metrics.size.width*0.8, height: 50, alignment: .center)
                    }else {
                        Text("手机号码: \(saveTel)")
                            .font(.title)
                    }
                    
                    Spacer()
                    Spacer()
                    Button {
                        if change {
                            if !telphone.isEmpty && captcha == register {
                                UserAttribute.ChangeTelphone(uid: saveUid, telphone: telphone) { result in
                                    if result["code"] as! Int == 0 {
                                        saveTel = telphone
                                        message = "修改成功"
                                    }else {
                                        message = "修改失败"
                                    }
                                }
                            }else {
                                message = "请正确输入信息"
                            }
                            change.toggle()
                            changed.toggle()
                        }else {
                            telphone = ""
                            captcha = ""
                            change.toggle()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 150, height: 50, alignment: .center)
                            .padding(.vertical, 10)
                            .overlay {
                                Text("修改手机号码")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                    .alert(isPresented: $changed) {
                        Alert(title: Text(message), dismissButton: .default(Text("确认")))
                    }
                    
                    Spacer()
                }
                .onAppear {
                    self.delay = 0
                }
                .onReceive(timer) { time in
                    if self.delay > 0 {
                        self.delay -= 1
                    }
                }
            }
        }
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
         PhoneView()
    }
}
