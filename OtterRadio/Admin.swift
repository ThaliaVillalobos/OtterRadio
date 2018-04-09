//
//  Admin.swift
//  OtterRadio
//
//  Created by Mario Martinez on 4/5/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import Parse


class Admin {
    
    init() {
        print("Admin initialized")
        print(PFUser.current()?.objectId ?? "No user")
    }
    

}
