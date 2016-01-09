
//  Created by Ian Dundas on 08/01/2016.

import UIKit
import ReactiveKit
import ReactiveUIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var switchIndicator: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var errorBox: UIView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* ~~ 1: Bind the controls to the ViewModel: ~~ */
        textField.rText.bindTo(viewModel.nameString)
        button.rTap.bindTo(viewModel.submitEventStream) // button `taps` are sent to the viewModel
        
        
        /* ~~ 2: Bind the ViewModel to the controls: ~~ */
        viewModel.nameIsValidBool.bindTo(switchIndicator.rOn) // switch goes on/off depending on nameIsValid
        
        // error string shown in Label:
        viewModel.nameValidationString.bindTo(label.rText)
        
        // label is hidden or shown based on `shouldShowErrorIndicators`
        viewModel.shouldShowErrorIndicators
            .map{should in return !should} // true becomes false, false becomes true..
            .bindTo(label.rHidden)

        // errorBox has background set to Red or White depending on validity (just to demo something other than .hidden :P) 
        viewModel.shouldShowErrorIndicators
            // Map Boolean value to a UIColor value:
            .map{ should in return (should ? UIColor.redColor() : UIColor.whiteColor())}
            .bindTo(errorBox.rBackgroundColor)
    }
}

