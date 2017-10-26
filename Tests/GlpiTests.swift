/*
 * LICENSE
 *
 * GlpiTests.swift is part of the GLPI API Client Library for Swift,
 * a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 * Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon - <hrondon@teclib.com>
 * @date      13/10/17
 * @copyright (C) 2017 Teclib' and contributors
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/ios-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */

import XCTest
@testable import Glpi
import Alamofire

class GlpiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitSession() {
        
        let expectationResult = expectation(description: "initSession")
        
        let expectedUserToken = Constants.initSessionTesting["userToken"] ?? ""
        let expectedAppToken = Constants.initSessionTesting["appToken"] ?? ""
        let expectedMethod = Constants.initSessionTesting["method"] ?? ""
        
        Alamofire.request(Routers.initSession(expectedUserToken, expectedAppToken)).response { response in

            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Authorization") ?? "", "user_token \(expectedUserToken)")
            XCTAssertEqual(response.request?.httpMethod ?? "", expectedMethod)
            XCTAssertEqual(response.response?.statusCode ?? 0, 200)
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testKillSession() {
        
        let expectationResult = expectation(description: "KillSession")
        
        Alamofire.request(Routers.killSession).response { response in
            XCTAssertEqual(response.request?.value(forHTTPHeaderField: "Content-Type") ?? "", "application/json")
            XCTAssertEqual(response.request?.httpMethod ?? "", "GET")
            XCTAssertEqual(response.response?.statusCode ?? 0, 400)
            expectationResult.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
