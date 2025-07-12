//
//  AlertManager.swift
//  test
//
//  Created by Kunal Personl on 29/01/24.
//

import Foundation
import SwiftUI
import Combine

struct GlobalAlertItem {
    var title: String
    var message: String
    var primaryButtonTitle: String
    var primaryAction: (() -> Void)?
    var secondaryButtonTitle: String?
    var secondaryAction: (() -> Void)?
}

class AlertManager: ObservableObject {
    static let shared = AlertManager()

    @Published var isPresented: Bool = false
    @Published private(set) var currentAlert: GlobalAlertItem?

    private var alertStack: [GlobalAlertItem] = []

    private init() {}

    func showAlert(title: String,
                   message: String,
                   primaryButton: String = "OK",
                   primaryAction: (() -> Void)? = nil,
                   secondaryButton: String? = nil,
                   secondaryAction: (() -> Void)? = nil) {
        let alert = GlobalAlertItem(
            title: title,
            message: message,
            primaryButtonTitle: primaryButton,
            primaryAction: primaryAction,
            secondaryButtonTitle: secondaryButton,
            secondaryAction: secondaryAction
        )

        alertStack.append(alert)
        presentTopAlertIfNeeded()
    }

    private func presentTopAlertIfNeeded() {
        
        if(isPresented) {
            isPresented = false
            currentAlert = nil
        }
        
        guard let topAlert = alertStack.last else { return }
        currentAlert = topAlert
        isPresented = true
    }

    func dismissCurrent() {
        guard let alert = alertStack.popLast() else { return }

        

        // Present next alert if available
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.presentTopAlertIfNeeded()
        }
    }
    
    
    func dismissCurrentAlert(didTapPrimary: Bool) {
        guard let alert = alertStack.popLast() else { return }

        // Execute action before resetting to avoid double-dismiss
        if didTapPrimary {
            alert.primaryAction?()
        } else {
            alert.secondaryAction?()
        }

        isPresented = false
        currentAlert = nil

        // Present next alert if available
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.presentTopAlertIfNeeded()
        }
    }
}



struct GlobalAlertView: ViewModifier {
    @ObservedObject var alertManager = AlertManager.shared

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $alertManager.isPresented) {
                guard let alert = alertManager.currentAlert else {
                    return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("OK")))
                }

                if let secondary = alert.secondaryButtonTitle {
                    return Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        primaryButton: .default(Text(alert.primaryButtonTitle)) {
                            alertManager.dismissCurrentAlert(didTapPrimary: true)
                        },
                        secondaryButton: .cancel(Text(secondary)) {
                            alertManager.dismissCurrentAlert(didTapPrimary: false)
                        }
                    )
                } else {
                    return Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: .default(Text(alert.primaryButtonTitle)) {
                            alertManager.dismissCurrentAlert(didTapPrimary: true)
                        }
                    )
                }
            }
    }
}


extension View {
    func attachGlobalAlert() -> some View {
        self.modifier(GlobalAlertView())
    }
}
