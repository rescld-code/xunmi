//
//  PillsDetail.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/6.
//

import SwiftUI

struct PillsDetail: View {
    
    @Binding var show: Bool
    @Binding var id: Int
    
    @State var text: String = "Loading...."
    @State var alert: Bool = false
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .opacity(0.8)
                
                Rectangle()
                    .frame(width: metrics.size.width * 0.9, height: 200, alignment: .center)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            show.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                        .offset(x: -20, y: 20)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        NavigationLink {
                            ReportView()
                                .navigationTitle("举报")
                        } label: {
                            Text("举报")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                        }
                        .offset(x: -60, y: -10)
                        
                        Button {
                            alert.toggle()
                        } label: {
                            Text("互动")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                        }
                        .alert(isPresented: $alert) {
                            Alert(title: Text("功能正在维护中...."), dismissButton: .default(Text("确认")))
                        }
                        .offset(x: -20, y: -10)
                    }
                    .overlay(alignment: .bottomLeading) {
                        Text("PillsID: \(id)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .offset(x: 20, y: -10)
                    }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100, alignment: .center)
                    .offset(y: -100)
                
                Image("Blue")
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                    .offset(y: -100)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 231.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, opacity: 1.0))
                    .frame(width: metrics.size.width * 0.75, height: 100, alignment: .center)
                    .overlay(alignment: .center, content: {
                        Text(text)
                    })
                    .onAppear {
                        Pills.GetPills(id: id) { result in
                            guard let pills = result["pills"] as? [String: Any] else {
                                return
                            }
                            text = pills["Text"] as! String
                        }
                    }
            }
        }
    }
}

struct PillsDetail_Previews: PreviewProvider {
    static var previews: some View {
        PillsDetail(show: .constant(false), id: .constant(0))
    }
}
