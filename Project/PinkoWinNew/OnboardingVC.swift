
import UIKit
import Combine
import IonicPortals

class OnboardingVC: UIViewController {
    var continueCancellable: AnyCancellable?

    override func viewDidLoad() {
        continueCancellable = PortalsPubSub.publisher(for: "continue")
            .data(as: String.self)
            .filter { $0 == "cancel" || $0 == "success" }
            .receive(on: DispatchQueue.main)
            .sink { _ in
                State.shared.setIsNotFirstLaunch()
                self.dismiss(animated: true)
            }

        super.viewDidLoad()
    }

    override func loadView() {
        self.view = PortalUIView(portal: portalOnboarding)
    }
}

