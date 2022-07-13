//
//  ReportView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/10.
//

import SwiftUI

struct ReportView: View {
    let textLimit: Int = 240
    @ObservedObject var text = TextLimiter(limit: 240)
    
    @State var alert: Bool = false
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                ScrollView {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(.systemGray6))
                        .opacity(0.9)
                        .frame(width: metrics.size.width*0.95, height: 200)
                        .overlay(alignment: .topLeading) {
                            if text.value.isEmpty {
                                VStack {
                                    HStack {
                                        Text("请描述您的问题，以便我们提供更好的帮助")
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                            TextEditor(text: $text.value)
                                .padding(5)
                                .overlay(alignment: .bottomTrailing) {
                                    Text("\(text.value.count)/\(textLimit)")
                                        .offset(x: -3, y: -5)
                                }
                        }
                    
                    Button {
                        if !text.value.isEmpty {
                            alert.toggle()
                            text.value = ""
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                            .frame(width: 150, height: 50, alignment: .center)
                            .padding(.vertical, 10)
                            .overlay {
                                Text("提交")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                    .alert(isPresented: $alert, content: {
                        Alert(title: Text("提交成功"), dismissButton: .default(Text("确认")))
                    })
                    .padding(.top)
                }
            }.onAppear() {
                UITextView.appearance().backgroundColor = .clear
            }.onDisappear() {
                UITextView.appearance().backgroundColor = nil
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
