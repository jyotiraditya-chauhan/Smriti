//
//  GlassSheetBackground.swift
//  Smriti
//
//  Created by Aditya Chauhan on 20/01/26.
//

import SwiftUI
import UIKit

struct GlassSheetBackground: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        DispatchQueue.main.async {
            guard let sheet = controller.presentationController as? UISheetPresentationController else { return }
            sheet.containerView?.backgroundColor = .clear
            sheet.presentedViewController.view.backgroundColor = .clear
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            blur.frame = sheet.containerView?.bounds ?? .zero
            blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sheet.containerView?.insertSubview(blur, at: 0)
            sheet.presentedViewController.view.layer.cornerRadius = 28
            sheet.presentedViewController.view.clipsToBounds = true
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
