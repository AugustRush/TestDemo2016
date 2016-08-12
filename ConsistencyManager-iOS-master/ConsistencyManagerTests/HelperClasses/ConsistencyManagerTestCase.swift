// © 2016 LinkedIn Corp. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import Foundation
import XCTest
@testable import ConsistencyManager

/**
 This class defines a bunch of useful helper functions that are useful for writing tests for this library.
 Originally, these were helper methods, but it turns out that you should only use expectations from an XCTestCase subclass so this seemed like a good solution.
 */
class ConsistencyManagerTestCase: XCTestCase {
    func addListener(listener: ConsistencyManagerListener, toConsistencyManager consistencyManager: ConsistencyManager) {
        consistencyManager.listenForUpdates(listener)

        waitOnDispatchQueue(consistencyManager)
    }

    func removeListener(listener: ConsistencyManagerListener, fromConsistencyManager consistencyManager: ConsistencyManager) {
        consistencyManager.removeListener(listener)

        waitOnDispatchQueue(consistencyManager)
    }

    func updateWithNewModel(model: ConsistencyManagerModel, consistencyManager: ConsistencyManager, context: Any? = nil) {
        consistencyManager.updateWithNewModel(model, context: context)

        // First we need to wait for the consistency manager to finish on its queue
        waitOnDispatchQueue(consistencyManager)

        // Now, we need to wait for the main queue to do the actual updates
        waitOnMainThread()
    }

    /**
     This helper function is useful for testing projections.
     We want to validate the fields of our model, but aren't sure if it's a TestModel or ProjectionTestModel.
     This converts it to a TestModel and allows us to test the fields of the model.
     */
    func testModelFromListenerModel(model: ConsistencyManagerModel?) -> TestModel? {
        if let model = model as? TestModel {
            return model
        } else if let model = model as? ProjectionTestModel {
            return TestModel.testModelFromProjection(model)
        } else {
            XCTFail("Cannot convert listener model to test model.")
            return nil
        }
    }

    func deleteModel(model: ConsistencyManagerModel, consistencyManager: ConsistencyManager, context: Any? = nil) {
        consistencyManager.deleteModel(model, context: context)

        // First we need to wait for the consistency manager to finish on its queue
        waitOnDispatchQueue(consistencyManager)

        // Now, we need to wait for the main queue to do the actual updates
        waitOnMainThread()
    }

    func pauseListeningForUpdates(listener: ConsistencyManagerListener, consistencyManager: ConsistencyManager) {
        // This is synchronous so no wait is necessary here. This is just for readability and consistency with resume.
        consistencyManager.pauseListeningForUpdates(listener)
    }

    func resumeListeningForUpdates(listener: ConsistencyManagerListener, consistencyManager: ConsistencyManager) {
        consistencyManager.resumeListeningForUpdates(listener)

        // First we need to wait for the consistency manager to finish on its queue
        waitOnDispatchQueue(consistencyManager)

        // Now, we need to wait for the main queue to do the actual updates
        waitOnMainThread()
    }

    func waitOnDispatchQueue(consistencyManager: ConsistencyManager) {
        let expectation = expectationWithDescription("Wait for consistency manager to update internal state")

        let operation = NSBlockOperation() {
            expectation.fulfill()
        }
        consistencyManager.queue.addOperation(operation)

        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error)
        }
    }

    func waitOnMainThread() {
        let expectation = expectationWithDescription("Wait for main queue to finish so the updates have happened")

        dispatch_async(dispatch_get_main_queue()) {
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { error in
            XCTAssertNil(error)
        }
    }

    func traverseModelTreeDFS(model: ConsistencyManagerModel, parent: String) {
        if let id = model.modelIdentifier {
            print("\(id), child of \(parent)")
            model.forEach() {
                child in self.traverseModelTreeDFS(child, parent: id)
            }
        }
    }
}
