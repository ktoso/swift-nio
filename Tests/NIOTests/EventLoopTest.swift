//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2017-2018 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import Foundation
import XCTest
import NIO
import Dispatch

public class EventLoopTest : XCTestCase {
    
    public func testSchedule() throws {
        let nanos = DispatchTime.now().uptimeNanoseconds
        let amount: TimeAmount = .seconds(1)
        let eventLoopGroup = try MultiThreadedEventLoopGroup(numThreads: 1)
        defer {
            let _ = try? eventLoopGroup.close()
        }
        let value = try eventLoopGroup.next().schedule(task: {
            return true
        }, in: amount).wait()
        
        XCTAssertTrue(DispatchTime.now().uptimeNanoseconds - nanos >= amount.nanoseconds)
        XCTAssertTrue(value)
    }
}