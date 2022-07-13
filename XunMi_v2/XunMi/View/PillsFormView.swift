//
//  PillsFormView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/7.
//

import SwiftUI
import MapKit

struct PillsFormView: View {
    let locationTool = LocationTool()
    
    @State var uid: Int = -1
    @State var pills: PillsAttribute = PillsAttribute()
    
    @AppStorage("uid") var saveUid: Int = -1
    
    @State var selectTheme: Bool = false
    @State var inputText: Bool = false
    @State var locationText: String = ""
    @State var searchLocation: Bool = false
    @State var image: Bool = false
    @State var alert: Bool = false
    @State var message: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.clear)
                ScrollView {
                    VStack {
                        pillsStyle
                            .overlay {
                                Circle()
                                    .fill(Color("Blue"))
                                    .frame(width: metrics.size.width, height: metrics.size.height, alignment: .center)
                                    .offset(y: -1*metrics.size.height/7)
                                    .overlay {
                                        pillsStyle
                                    }
                            }
                            .padding(.vertical, 50)
                            .overlay(alignment: .bottomTrailing) {
                                HStack {
                                    Spacer()
                                    Text("仅自己可见")
                                        .font(.body)
                                    Toggle("privacy", isOn: $pills.privacy)
                                        .labelsHidden()
                                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                                }
                                .padding(.trailing, 30)
                            }
                        
                        LazyHGrid(rows: Array(repeating: .init(.fixed(120)), count: 2)) {
                            
                            Group {
                                themeButton
                                
                                textButton
                                
                                locationButton
                                
                                imageButton
                            }
                            .padding()
                        }
                        
                        VStack {
                            Button {
                                if pills.latitude != 0.0 && pills.longitude != 0.0 && !pills.text.isEmpty {
                                    Pills.PutPills(pills: pills) { result in
                                        if result["code"] as! Int == 0 {
                                            message = "投放成功"
                                            alert.toggle()
                                            presentationMode.wrappedValue.dismiss()
                                        }else {
                                            message = "投放失败"
                                            alert.toggle()
                                        }
                                    }
                                }else {
                                    message = "请正确输入信息"
                                    alert.toggle()
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("Blue"))
                                    .frame(height: 50, alignment: .center)
                                    .padding(.horizontal, 50)
                                    .opacity(0.7)
                                    .overlay {
                                        Text("投放")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                            }
                            .alert(isPresented: $alert) {
                                Alert(title: Text(message), dismissButton: .default(Text("确认")))
                            }
                            
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 50, alignment: .center)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 50)
                                    .opacity(0.7)
                                    .overlay {
                                        Text("取消")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                            }
                            .padding(.bottom, 20)
                        }
                        .padding()
                    }
                    .background(.white)
                    .cornerRadius(50)
                    .padding()
                }
                
                
                if inputText {
                    PillsTextEditor(text: $pills.text, show: $inputText)
                }
                
                if searchLocation {
                    PillsLocationSearch(text: $locationText, latitude: $pills.latitude, longitude: $pills.longitude, show: $searchLocation)
                }
            }
            .onAppear {
                self.uid = saveUid
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .background(.linearGradient(colors: [Color("Blue"), Color("Blue2")], startPoint: .top, endPoint: .bottom))
        }
    }
    
    var locationButton: some View {
        Button {
            searchLocation.toggle()
        } label: {
            if pills.longitude != 0.0 {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color("Blue3"))
                    .frame(width: 130, height: 100, alignment: .center)
                    .overlay {
                        Text("位置")
                            .font(.title)
                    }
            }else {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color("Gray"))
                    .frame(width: 130, height: 100, alignment: .center)
                    .overlay {
                        Text("位置")
                            .font(.title)
                    }
            }
        }

    }
    
    var pillsStyle: some View {
        HStack {
            Spacer()
            Image(pills.theme.rawValue)
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            Spacer()
        }
    }
    
    var themeButton: some View {
        Button {
            selectTheme.toggle()
        }label: {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("Blue3"))
                .frame(width: 130, height: 100, alignment: .center)
                .overlay{
                    Text("主题")
                        .font(.title)
                }
        }
        .alert("选择主题", isPresented: $selectTheme) {
            Button("黄色") {
                pills.theme = PillsTheme.Yellow
            }
            Button("蓝色") {
                pills.theme = PillsTheme.Blue
            }
            Button("红色") {
                pills.theme = PillsTheme.Red
            }
            Button("绿色") {
                pills.theme = PillsTheme.Green
            }
        }
    }
    
    var textButton: some View {
        Button {
            inputText.toggle()
        } label: {
            if pills.text != "" {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color("Blue3"))
                    .frame(width: 130, height: 100, alignment: .center)
                    .overlay {
                        Text("留言")
                            .font(.title)
                    }
            }else {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color("Gray"))
                    .frame(width: 130, height: 100, alignment: .center)
                    .overlay {
                        Text("留言")
                            .font(.title)
                    }
            }
        }
    }
    
    var imageButton: some View {
        Button {
            image.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("Gray"))
                .frame(width: 130, height: 100, alignment: .center)
                .overlay {
                    Text("拍照")
                        .font(.title)
                }
        }
        .alert(isPresented: $image) {
            Alert(title: Text("功能维护中...."), dismissButton: .default(Text("确认")))
        }
    }
}

struct PillsFormView_Previews: PreviewProvider {
    static var previews: some View {
        PillsFormView()
        PillsFormView()
            .preferredColorScheme(.dark)
    }
}
