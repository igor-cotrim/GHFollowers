//
//  UiViewController+Ext.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 11/06/25.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String = "Ok") {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
    func presentSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
