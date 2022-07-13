//
//  FootprintView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/9.
//

import SwiftUI

struct FootprintView: View {
    
    @State var times: [String] = []
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                ScrollView {
                    
                    HStack {
                        Text("踩点图")
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .padding(.leading, 25)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                    Image("Map")
                        .resizable()
                        .frame(width: metrics.size.width*0.9, height: metrics.size.height/3, alignment: .center)
                        .overlay {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .opacity(0.7)
                        }
                        .overlay {
                            Text("正在开发中....")
                                .foregroundColor(.gray)
                        }
                    
                    HStack {
                        Text("登陆状态")
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .padding(.leading, 25)
                            .foregroundColor(.black)
                        Spacer()
                    }
                }
                
                List {
                    Section {
                        ForEach(times, id: \.self) { item in
                            HStack {
                                Text(item)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            .foregroundColor(.gray)
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .onAppear {
                    Logs.login { result in
                        times = result["times"] as! [String]
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("足迹")
        }
    }
}

struct FootprintView_Previews: PreviewProvider {
    static var previews: some View {
        FootprintView()
    }
}
