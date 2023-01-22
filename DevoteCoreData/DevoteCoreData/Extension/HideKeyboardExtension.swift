//
//  HideKeyboardExtension.swift
//  DevoteCoreData
//
//  Created by Gurjinder Singh on 22/01/23.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
