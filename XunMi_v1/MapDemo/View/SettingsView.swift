//
//  SettingsView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/2.
//

import SwiftUI

struct SettingsView: View {
    @Binding var uid: Int
    @Binding var showBottomMenu: Bool
    
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        List {
            Text("账户与安全")
            Text("足迹设置")
            Button("关于") {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("关于"), message: Text("福建信息职业技术学院") ,dismissButton: .default(Text("确认")))
            }
            
            Button("清除缓存") {
                uid = -1
                showAlert.toggle()
                showBottomMenu.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("清除成功"), dismissButton: .default(Text("确认")))
            })
        }
        .foregroundColor(.black)
        .onAppear {
            showBottomMenu = false
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    showBottomMenu = true
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("About")
                    }
                }

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(uid: .constant(-1), showBottomMenu: .constant(false))
    }
}
