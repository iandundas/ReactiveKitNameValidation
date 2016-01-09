
//  Created by Ian Dundas on 08/01/2016.

import Foundation
import ReactiveKit

class ViewModel{
    
    /*  An <ActiveStream> simply streams events as they happen (i.e. new values) from the moment you call .observeNext on it. 
        Any values that occured *before* you *observed* it are forgotten.
        Therefore they have a memory of 0 items.
    
        It sends values regardless of whether it has any subscribers.
    */
    var submitEventStream = ActiveStream<Void>()
    
    /*  An <Observable> is a kind of Active Stream, but it buffers the last value, so when we observe it, we get that value immediately.
        There is also a method `.value` on an Observable which hands us immediately the latest value, which is very convenient.
        They have a memory of 1 item.
        NB this is called a Signal in Interstellar.
        This is basically like a variable that emits "value did change" events.
        */
    
    var nameString: Observable<String?>
    var shouldShowErrorIndicators = Observable<Bool>(false)
    
    /*  <Stream> types lie dormant doing nothing until they are observed. It defers all work and the sending of any 
        values until it has an observer. We can't set the value ourself.*/
    var nameValidationString: Stream<String?>
    var nameIsValidBool: Stream<Bool>
    
    init(){
        nameString = Observable<String?>(nil)
        
        nameValidationString = nameString.map { potentialName -> String? in
            guard let name = potentialName where name.characters.count > 0 else { return "Please provide a name" }
            return name.characters.count >= 3 ? nil : "Name should contain at least 3 characters"
        }

        nameIsValidBool = nameValidationString.map{ errorMessage in (errorMessage == nil)}

        let combineSubmitEventWithNameIsValid = submitEventStream.combineLatestWith(nameIsValidBool.map{!$0})

        // map `combineSubmitEventWithNameIsValid` to only the `isInvalid` bit of the tuple, return it and bind that to shouldShowErrorIndicators
        combineSubmitEventWithNameIsValid.map{_, isInvalid in isInvalid}.bindTo(shouldShowErrorIndicators)
    }
}
