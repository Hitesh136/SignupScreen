//
//  Temp.swift
//  CoolLoginScreens
//
//  Created by Hitesh Agarwal on 08/02/20.
//  Copyright © 2020 Hitesh Agarwal. All rights reserved.
//

import SwiftUI

struct Temp: View {
    
    @State var tempText: String = "agarwal.hitesh94@gamil.com"
    var body: some View {
        TextField("Enter some text", text: $tempText)
            .foregroundColor(.blue)
    }
}

struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        Temp()
    }
}
