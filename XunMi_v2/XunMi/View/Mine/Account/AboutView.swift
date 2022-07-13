//
//  AboutView.swift
//  XunMi
//
//  Created by 残云cyun on 2022/7/6.
//

import SwiftUI

struct AboutView: View {
    
    @AppStorage("uid") var uid: Int = -1
    @AppStorage("username") var username: String = "Username"
    
    @State var cooperation: Bool = false
    @State var version: Bool = false
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 130, height: 130, alignment: .center)
                        .background(LinearGradient(colors: [Color(red: 49/255, green: 209/255, blue: 255/255),
                                                            Color(red: 41/255, green: 121/255, blue: 255/255, opacity: 1)],
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                        .padding(.bottom, 10)
                        .padding(.top, 50)
                    
                    Text("寻觅")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Version 1.0 Alpha")
                        .font(.body)
                        .padding(.bottom, 30)
                    
                    ScrollView {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: metrics.size.width*0.95, height: 110, alignment: .center)
                            .overlay {
                                VStack {
                                    Button {
                                        version.toggle()
                                    } label: {
                                        HStack {
                                            Text("检查更新")
                                                .frame(height: 40)
                                                .padding(.leading, 20)
                                            Spacer()
                                            Text("Version 1.0 Alpha")
                                                .padding(.trailing, 30)
                                                .foregroundColor(.gray)
                                        }
                                        .foregroundColor(.black)
                                    }
                                    .alert(isPresented: $version) {
                                        Alert(title: Text("无更新"), dismissButton: .default(Text("确认")))
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal, 25)
                                    
                                    Button {
                                        cooperation.toggle()
                                    } label: {
                                        HStack {
                                            Text("合作洽谈")
                                                .foregroundColor(.black)
                                                .frame(height: 40)
                                                .padding(.leading, 20)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("福建信息职业技术学院 版权所有")
                        Text("Copyright &copy; 2022 FJPIT. All Rights Reserved.")
                    }
                    .font(.footnote)
                    .padding(1)
                    .foregroundColor(.gray)
                }
                
                if cooperation {
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                Text("合作洽谈")
                                    .font(.title)
                                    .padding(.top, 40)
                                Spacer()
                            }
                            
                            Group {
                                Text("合作和报道请使用一下邮箱。如需反馈寻觅使用问题或建议，请返回进入[服务中心]提交。")
                                Text("商务合作：staff@rescld.cn")
                                Text("校园合作：school@rescld.cn")
                                Text("文章投稿：article@rescld.cn")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                            
                            HStack {
                                Spacer()
                                Button {
                                    cooperation.toggle()
                                } label: {
                                    Text("确认")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 40, alignment: .center)
                                        .background(.blue)
                                        .cornerRadius(10)
                                        .padding()
                                        .padding(.bottom)
                                }

                                Spacer()
                            }
                        }
                        .background(.white)
                        .cornerRadius(20)
                    .padding(.horizontal, 30)
                    }
                }
            }
            .navigationTitle("关于我们")
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
