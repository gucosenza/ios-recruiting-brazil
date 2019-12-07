import UIKit

class MovieViewController: UIViewController {
    
    let spinnerView = SpinnerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Color4")
        self.title = "Movies"
        
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(named: "Color1")
        
        self.view = spinnerView.startSpinner(self.view.bounds)
    }


}


