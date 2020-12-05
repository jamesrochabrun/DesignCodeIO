//
//  UpdateDetail.swift
//  SwiftUIDesignCodeIO
//
//  Created by james rochabrun on 11/13/20.
//

import SwiftUI

struct UpdateDetail: View {
    
    var update: Update = updateData.first!
    
    var body: some View {
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        }
        .listStyle(GroupedListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
