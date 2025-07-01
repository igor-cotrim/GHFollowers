//
//  UiViewController+Ext.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 11/06/25.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentGFAlert(title: String, message: String, buttonTitle: String = "Ok") {
        let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        present(alertViewController, animated: true)
    }
    
    func presentDefaultError() {
        let alertViewController = GFAlertViewController(title: "Something went wrong",
                                                        message: "We were unable to complete your task. Please try again later.",
                                                        buttonTitle: "Ok")
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        present(alertViewController, animated: true)
    }
    
    func presentSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
