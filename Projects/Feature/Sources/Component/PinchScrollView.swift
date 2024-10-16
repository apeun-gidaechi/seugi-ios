import Foundation
import SwiftUI
import Combine

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
        
        init(coordinator: Coordinator) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
            self.view = scrollView
            
            scrollView.delegate = self
            scrollView.maximumZoomScale = 3.0
            scrollView.minimumZoomScale = 1.0
            scrollView.bouncesZoom = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.clipsToBounds = false
            scrollView.backgroundColor = .clear
            
            /* Manual hostedView from SwiftUI */
            let hostedView = coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            hostedView.backgroundColor = .clear
            hostedView.alpha = 0
            scrollView.addSubview(hostedView)
            
            view.setNeedsUpdateConstraints()
        }
        
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
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
                hostedView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                hostedView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])
        }
        
        override func viewDidAppear(_ animated: Bool) {
            scrollView.zoomScale = 1.0
            alignment()
            view.setNeedsUpdateConstraints()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.recenter()
                self?.hostedView.alpha = 1
            }
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
