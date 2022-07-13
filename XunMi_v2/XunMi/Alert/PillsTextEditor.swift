//
//  PillsTextEditor.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import SwiftUI

struct PillsTextEditor: View {
    
    @Binding var text: String
    @Binding var show: Bool
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 10/255, green: 149/255, blue: 255/255, opacity: 1.0))
                    .frame(width: metrics.size.width * 0.8, height: 280, alignment: .center)
                    .shadow(color: .cyan, radius: 5, x: 0, y: 0)
                    .overlay {
                        VStack {
                            Text("留言")
                                .font(.title)
                                .padding(.top)
                                .foregroundColor(.white)
                            TextEditor(text: $text)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            Button {
                                show.toggle()
                            } label: {
                                Rectangle()
                                    .fill(.ultraThickMaterial)
                                    .cornerRadius(10)
                                    .overlay {
                                        Text("确认")
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 80, height: 40, alignment: .center)
                                    .padding()
                            }
                        }
                    }
            }
        }
    }
}

struct PillsTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        PillsTextEditor(text: .constant("test"), show: .constant(true))
    }
}
