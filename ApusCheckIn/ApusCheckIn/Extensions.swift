//
//  Extensions.swift
//  ApusCheckIn
//
//  Created by Han Gyul Kim on 2022/02/24.
//

import Foundation
import SwiftUI
import Firebase

extension UIAlertController {
  convenience init(alert: TextAlert) {
    self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
    addTextField {
       $0.placeholder = alert.placeholder
       $0.keyboardType = alert.keyboardType
    }
    if let cancel = alert.cancel {
      addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
        alert.action(nil)
      })
    }
    if let secondaryActionTitle = alert.secondaryActionTitle {
       addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { _ in
         alert.secondaryAction?()
       }))
    }
    let textField = self.textFields?.first
    addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
      alert.action(textField?.text)
    })
  }
}

extension View {
  public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
    AlertWrapper(isPresented: isPresented, alert: alert, content: self)
  }
}

extension Firestore {
    func addIntraID(collection: String, document: String, intraID: String) {
        self.collection(collection).document(document).setData(["intraID" : "*\(intraID)*"], merge: true)
    }
    
    func addTodayToDates(collection: String, document: String) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyMMdd"
        let today = dateformatter.string(from: Date())
        self.collection(collection).document(document).setData(["Dates": [today : Date()]], merge: true)
    }
}
