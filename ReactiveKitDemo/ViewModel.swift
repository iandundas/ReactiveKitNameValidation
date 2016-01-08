
//  Created by Ian Dundas on 08/01/2016.

import Foundation
import ReactiveKit

class ViewModel{
    
    // Mutable Observable properties:
    var name: Observable<String?>
    
    // Derived properties:
    var nameValidation: Stream<String?>
    var nameIsValid: Stream<Bool>
    
    init(){
        name = Observable<String?>(nil)
        
        nameValidation = name.map { potentialName -> String? in
            guard let name = potentialName else { return "please provide a name" }
            return name.characters.count >= 3 ? nil : "Name should contain at least 3 characters"
        }

        nameIsValid = nameValidation.map{ errorMessage in (errorMessage == nil)}
        
        
    }
    
}
