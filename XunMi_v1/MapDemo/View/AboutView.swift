//
//  AboutView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/2.
//

import SwiftUI

struct AboutView: View {
    @Binding var username: String
    @Binding var uid: Int
    
    @Binding var showMenu: Bool
    
    var body: some View {
        NavigationView {
            List{
                VStack {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(size: 32))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue, .blue.opacity(0.3))
                        .padding()
                        .background(Circle().fill(.ultraThinMaterial))
                        .background(
                            Image(systemName: "hexagon")
                                .symbolVariant(.fill)
                                .foregroundColor(.blue)
                                .font(.system(size: 200))
                                .offset(x: -50, y: -100)
                        )
                        .frame(maxWidth: .infinity)
                    
                    if uid == -1 {
                        ZStack {
                            NavigationLink {
                                SignInView(username: $username, uid: $uid, showBottomMenu: $showMenu)
                            } label: {
                                Color.clear
                            }
                            .opacity(0)
                            .buttonStyle(.plain)
                            
                            HStack {
                                Text("Login")
                                    .font(.title.weight(.semibold))
                            }
                        }
                    }else {
                        Text(username)
                            .font(.title.weight(.semibold))
                    }
                    Spacer()
                }
                .padding(.bottom)

                Section {
                    NavigationLink {
                        SettingsView(uid: $uid ,showBottomMenu: $showMenu)
                    } label: {
                        Label("Settings", systemImage: "gear")

                    }
                    
                    NavigationLink {
                        NoticeView(showBottomMenu: $showMenu)
                    } label: {
                        Label("Notice", systemImage: "envelope")
                    }
                    
                    NavigationLink {
                        FootprintView(showBottomMenu: $showMenu)
                    } label: {
                        Label("Footprint", systemImage: "pawprint")
                    }
                    
                    NavigationLink {
                        FeedbackView(showBottomMenu: $showMenu)
                    } label: {
                        Label("Feedback", systemImage: "camera.filters")
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(username: .constant("Login"), uid: .constant(-1), showMenu: .constant(true))
    }
}
