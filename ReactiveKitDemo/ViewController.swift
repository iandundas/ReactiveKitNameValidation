
//  Created by Ian Dundas on 08/01/2016.

import UIKit
import ReactiveKit
import ReactiveUIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var indicator: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Bind the controls to the ViewModel:
        textField.rText.bindTo(viewModel.name)
        
        // Bind the ViewModel to the controls:
        viewModel.nameValidation.bindTo(label.rText)
        viewModel.nameIsValid.bindTo(indicator.rOn)
    }
}

