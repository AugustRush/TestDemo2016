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


class TestListener: ConsistencyManagerListener {

    var model: ConsistencyManagerModel?
    var updateClosure: ((ConsistencyManagerModel?, ModelUpdates) -> ())?
    var contextClosure: ((Any?) -> ())?
    var currentModelRequested: (()->())?

    init(model: ConsistencyManagerModel?) {
        self.model = model
    }

    func currentModel() -> ConsistencyManagerModel? {
        assert(NSThread.currentThread().isMainThread)
        // Save the state here, because we may want to change the model for testing purposes in this block
        let model = self.model
        currentModelRequested?()
        return model
    }

    func modelUpdated(model: ConsistencyManagerModel?, updates: ModelUpdates, context: Any?) {
        assert(NSThread.currentThread().isMainThread)
        self.model = model
        if let updateClosure = updateClosure {
            updateClosure(model, updates)
        }
        if let contextClosure = contextClosure {
            contextClosure(context)
        }
    }
}
