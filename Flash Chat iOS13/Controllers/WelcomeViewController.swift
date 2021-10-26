// WelcomeViewController class is used to trigger first view of application
// CLTypingLabel Pod has been used to animate App name in animated way

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    // CLTypingLabel pod file is used to animate title label
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // To hide Navigation bar when Welcome view triggers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // To hide Navigation bar when Welcome view triggers
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "⚡️FlashChat"
    }
    
}

