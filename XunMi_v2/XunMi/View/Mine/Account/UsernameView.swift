//
//  UsernameView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/8.
//

import SwiftUI

struct UsernameView: View {

    @State var username: String = ""
    @State var change: Bool = false
    
    @AppStorage("uid") var saveUid: Int = -1
    @AppStorage("username") var saveUsername: String = ""
    
    @State var alert: Bool = false
    @State var message: String = ""
    
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
                            Text("用户名: ")
                                .font(.title)
                            TextField(username, text: $username)
                                .autocapitalization(.none)
                                .font(.title)
                                .background(.white)
                                .opacity(0.8)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        }
                        .frame(width: metrics.size.width*0.6, height: 50, alignment: .center)
                        .onAppear {
                            username = saveUsername
                        }
                    }else {
                        Text("用户名: \(saveUsername)")
                            .font(.title)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        if change {
                            UserAttribute.ChangeUsername(uid: saveUid, username: username) { result in
                                if result["code"] as! Int == 0 {
                                    saveUsername = username
                                    message = "修改成功"
                                }else {
                                    message = "修改失败，可能该用户名已被占用"
                                }
                                alert.toggle()
                                change.toggle()
                            }
                        }else {
                            change.toggle()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 150, height: 50, alignment: .center)
                            .padding(.vertical, 10)
                            .overlay {
                                Text("修改用户名")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                    .alert(isPresented: $alert) {
                        Alert(title: Text(message), dismissButton: .default(Text("确认")))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
