//
//  TFARequestProtocol.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/18/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation
import Alamofire

protocol TFARequestProtocol {
    
    var requestURL: String { get }
    var parameters: Dictionary< String, String> { get set }
    var headers: Dictionary< String, String> { get set }
    func parseRequest(data:Any) -> Any
}

extension TFARequestProtocol {
    
    func makeRequest(url:String, parameters:[String: String], headers:[String: String], success:@escaping (_ data:Dictionary<AnyHashable,Any>) -> Void, failure:@escaping (_ error:Error) -> Void){
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if let JSON = response.result.value {
                    
                    success(JSON as! Dictionary)
                }
            case .failure(let error):
                failure(error)
            }
        }
        
    }
    
    
}
