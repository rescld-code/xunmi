//
//  NoticeView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/9.
//

import SwiftUI

struct MessageView: View {
    @State private var messageToggle: Bool = true
    @State private var openPills: Bool = true
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                    .opacity(0.8)
                
                ScrollView {
                    HStack {
                        Text("互动提醒")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                    VStack {
                        Group {
                            Toggle("通知开关", isOn: $messageToggle)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Divider()
                            Toggle("胶囊动态", isOn: $openPills)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Divider()
                            Toggle("留言回复", isOn: .constant(false))
                                .foregroundColor(.gray)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Divider()
                            Toggle("已关注", isOn: .constant(false))
                                .foregroundColor(.gray)
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding(.horizontal, 20)
                        .onChange(of: messageToggle) { newValue in
                            openPills = newValue
                            messageToggle = newValue
                        }
                        .onChange(of: openPills) { newValue in
                            openPills = newValue
                            messageToggle = newValue
                        }
                    }
                    .padding(.vertical)
                    .background(.white)
                    .frame(width: metrics.size.width*0.95)
                    .cornerRadius(10)
                    
                    NavigationLink {
                       Text("暂时没有服务提醒")
                            .foregroundColor(.gray)
                            .navigationTitle("服务提醒")
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                            .overlay {
                                HStack {
                                    Text("服务提醒")
                                        .padding(.leading, 20)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .padding(.trailing, 20)
                                }
                                .foregroundColor(.black)
                            }
                    }
                    
                    NavigationLink {
                       Text("暂时没有系统通知")
                            .foregroundColor(.gray)
                            .navigationTitle("系统通知")
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: metrics.size.width*0.95, height: 50, alignment: .center)
                            .overlay {
                                HStack {
                                    Text("系统通知")
                                        .padding(.leading, 20)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .padding(.trailing, 20)
                                }
                                .foregroundColor(.black)
                            }
                    }
                }
                .padding(.top, 15)
            }
            .navigationTitle("消息通知")
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
