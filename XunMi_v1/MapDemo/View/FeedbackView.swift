//
//  FeedbackView.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/3.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var showBottomMenu: Bool
    
    var body: some View {
        Text("None")
            .onAppear {
                showBottomMenu = false
            }
            .navigationTitle("Feedback")
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

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView(showBottomMenu: .constant(false))
    }
}
