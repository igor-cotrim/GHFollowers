//
//  GFDataLoadingViewController.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 26/06/25.
//

import UIKit

class GFDataLoadingViewController: UIViewController {
    var containerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        guard let containerView = containerView else { return }
        
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicatorView.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            guard let containerView = self.containerView else { return }
            containerView.removeFromSuperview()
        }
    }
    
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView()
        emptyStateView.setup(message: message)
        emptyStateView.frame = view.bounds
        
        view.addSubview(emptyStateView)
    }

}
