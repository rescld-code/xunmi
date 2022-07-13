//
//  ServiceView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/9.
//

import SwiftUI

struct ServiceView: View {
    
    @State private var alert: Bool = false
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.8)
                    .offset(x: -250)
                    .clipped()
                
                Circle()
                    .foregroundColor(Color(red: 144/255.0, green: 177/255.0, blue: 249/255.0, opacity: 1.0))
                    .offset(x: metrics.size.width/4, y: -1*metrics.size.height/2)
                    .overlay {
                        Circle()
                            .fill(Color(red: 144/255.0, green: 177/255.0, blue: 249/255.0, opacity: 1.0))
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: metrics.size.width/4,y: metrics.size.height/2)
                    }
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .opacity(1)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: metrics.size.width*0.95, height: 500, alignment: .center)
                    .opacity(0.2)
                    .overlay {
                        service
                            .padding()
                    }
                
                if alert {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("服务中心")
        }
    }
    
    var service: some View {
        VStack {
            HStack {
                Text("帮助")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: .init(.fixed(150)), count: 2)) {
                Group {
                    NavigationLink {
                        FeedbackView()
                    } label : {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                            .frame(width: 130, height: 150, alignment: .center)
                            .overlay{
                                VStack {
                                    Image(systemName: "questionmark.circle")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("问题反馈")
                                        .padding(.top, 15)
                                }
                                .foregroundColor(.black)
                            }
                    }
                    
                    Button {
                        alert.toggle()
                    } label : {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                            .frame(width: 130, height: 150, alignment: .center)
                            .overlay{
                                VStack {
                                    Image(systemName: "airpodsmax")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("联系客服")
                                        .padding(.top, 15)
                                        .foregroundColor(.gray)
                                }
                                .foregroundColor(.black)
                            }
                    }
                    .alert(isPresented: $alert) {
                        Alert(title: Text("正在开发中...."), dismissButton: .default(Text("确认")))
                    }
                }
                .padding()
                .background(.clear)
            }
            
            HStack {
                Text("提议")
                    .font(.title3)
                    .fontWeight(.bold)
//                    .padding(.leading, 20)
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: .init(.fixed(150)), count: 2)) {
                Group {
                    NavigationLink {
                        ReportView()
                            .navigationTitle("意见箱")
                    }label: {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                            .frame(width: 130, height: 150, alignment: .center)
                            .overlay{
                                VStack {
                                    Image(systemName: "text.bubble")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("意见箱")
                                        .padding(.top, 15)
                                }
                                .foregroundColor(.black)
                            }
                    }
                    
                    NavigationLink {
                        ReportView()
                            .navigationTitle("投诉箱")
                    } label: {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                            .frame(width: 130, height: 150, alignment: .center)
                            .overlay{
                                VStack {
                                    Image(systemName: "exclamationmark.bubble")
                                        .font(.system(size: 40))
                                        .foregroundColor(.blue)
                                    Text("投诉箱")
                                        .padding(.top, 15)
                                }
                                .foregroundColor(.black)
                            }
                    }
                }
                .padding()
                .background(.clear)
            }
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
