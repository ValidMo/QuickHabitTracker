//
//  UITestView3.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 2.06.2024.
//

import SwiftUI
import UIKit

struct UITestView3: View {

    var body: some View {
        Button("Tap") {
            print("Normal Tap")
        }
        .padding()
        .border(Color.blue, width: 1)
        .cornerRadius(15)
        
        .highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    print("Tap")
                }
        )
        .contextMenu {
            Button("Delete", role: .destructive) {
                print("Delete")
            }
            Button(action: {
                print("Edit")
            }) {
                Text("Edit")
            }
          
        }
    }
}


#Preview {
    UITestView3()
}
