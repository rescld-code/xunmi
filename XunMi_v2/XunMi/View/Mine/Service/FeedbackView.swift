//
//  FeedbackView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/9.
//

import SwiftUI

struct FeedbackView: View {
    let textLimit: Int = 240
    
    @State private var alert: Bool = false
    @State private var submit: Bool = false
    @State private var telephone: String = ""
    @ObservedObject var text = TextLimiter(limit: 240)
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color.clear
                
                ScrollView {
                    VStack {
                        HStack {
                            Text("联系方式（必填）")
                                .font(.title3)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(.systemGray6))
                            .opacity(0.9)
                            .frame(height: 50)
                            .overlay(alignment: .topLeading) {
                                if telephone.isEmpty {
                                    HStack {
                                        Text("请输入您的联系方式")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 10)
                                        Spacer()
                                    }
                                }
                                TextEditor(text: $telephone)
                                    .padding(5)
                            }
                            .padding(.bottom, 30)
                        
                        HStack {
                            Text("反馈内容（必填）")
                                .font(.title3)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(.systemGray6))
                            .opacity(0.9)
                            .frame(height: 200)
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
                        Spacer()
                        
                        Button {
                            alert.toggle()
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(.systemGray6))
                                    .opacity(0.9)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                    }
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                        .alert(isPresented: $alert) {
                            Alert(title: Text("功能维护中...."), dismissButton: .default(Text("确认")))
                        }
                        
                        Button {
                            if !telephone.isEmpty && !text.value.isEmpty {
                                submit.toggle()
                                telephone = ""
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
                        .alert(isPresented: $submit) {
                            Alert(title: Text("提交成功"), dismissButton: .default(Text("确认")))
                        }
                    }
                }
                .padding()
                
                if alert {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                }
            }
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
