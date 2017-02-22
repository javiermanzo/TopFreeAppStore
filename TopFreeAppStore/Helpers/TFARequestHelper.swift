//
//  TFARequestHelper.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/18/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import Foundation

class TFARequestHelper {
    
    static let shared = TFARequestHelper()
    
    func getList(success:@escaping ( _ response:Any) -> Void, failure:@escaping ( _ error:Error) -> Void){
        
        let listRequest = TFAGetListRequest()
        
        listRequest.request(success: { (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
        
    }
    
}
