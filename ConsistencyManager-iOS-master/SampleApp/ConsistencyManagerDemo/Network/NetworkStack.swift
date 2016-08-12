// © 2016 LinkedIn Corp. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import Foundation
import ConsistencyManager

class Network {

    // This class fakes a network response
    class func fetchUpdates(callback: StreamModel -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let updates = Array(0..<20).map() { index in
                UpdateModel(id: "\(index)", liked: index % 2 == 0)
            }

            let stream = StreamModel(id: "100", updates: updates)
            dispatch_async(dispatch_get_main_queue()) {
                callback(stream)
            }
        }
    }
}
