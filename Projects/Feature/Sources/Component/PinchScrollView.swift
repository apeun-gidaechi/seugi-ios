//
//  PinchScrollView.swift
//  Feature
//
//  Created by hhhello0507 on 9/27/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import SwiftUI
import Then

struct PinchScrollView<Content: View>: UIViewControllerRepresentable {
    @ViewBuilder let content: Content

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController(coordinator: context.coordinator)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIViewController(_ viewController: ViewController, context: Context) {
        viewController.update(content: self.content)
    }
    
    class ViewController: UIViewController, UIScrollViewDelegate {
        let coordinator: Coordinator
        let scrollView = UIScrollView()
        
        private var hostedView: UIView { coordinator.hostingController.view! }
        
        private var contentSizeConstraints: [NSLayoutConstraint] = [] {
              willSet { NSLayoutConstraint.deactivate(contentSizeConstraints) }
              didSet { NSLayoutConstraint.activate(contentSizeConstraints) }
        }
        
        init(coordinator: Coordinator) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
            self.view = scrollView

            scrollView.do {
                $0.delegate = self
                $0.maximumZoomScale = 3.0
                $0.minimumZoomScale = 0.8
                $0.bouncesZoom = true
                $0.showsHorizontalScrollIndicator = false
                $0.showsVerticalScrollIndicator = false
                $0.backgroundColor = .black
            }
            
            /* Manual hostedView from SwiftUI */
            let hostedView = coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            hostedView.alpha = 0
            scrollView.addSubview(hostedView)
            alignment()
            
            recenter()
            view.setNeedsUpdateConstraints()
        }
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
        
        override func viewDidAppear(_ animated: Bool) {
            hostedView.sizeToFit()
            recenter()
            hostedView.alpha = 1
        }
                
        func update(content: Content) {
            coordinator.hostingController.rootView = content
            scrollView.setNeedsUpdateConstraints()
        }
        
        func alignment() {
            NSLayoutConstraint.activate([
                hostedView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                hostedView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                hostedView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                hostedView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                hostedView.bounds.width >= hostedView.bounds.height ? hostedView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor) : hostedView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])
        }
        
        func recenter() {
            let scrollViewSize = scrollView.bounds.size
            let contentViewSize = hostedView.frame.size
            let horizontalInset = contentViewSize.width < scrollViewSize.width ? (scrollViewSize.width - contentViewSize.width) / 2.0 : 0
            let verticalInset = contentViewSize.height < scrollViewSize.height ? (scrollViewSize.height - contentViewSize.height) / 2.0 : 0
            
            scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostedView
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            recenter()
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
    }
}
