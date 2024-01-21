//
//  SItemListView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI

struct SItemListView: View {
    var sitems: [SItem]
    var onShopSelected: (SItem) -> Void

    var body: some View {
        List(sitems) { sitem in
            NavigationLink(destination: SItemDetailView(sitem: sitem)) {
                SItemListRowView(sitem: sitem, onSelected: {
                    onShopSelected(sitem)
                })
            }
        }
    }
}

struct SItemListRowView: View {
    var sitem: SItem
    var onSelected: () -> Void
    
    var body: some View {
        HStack {
            if let uiImage = UIImage(data: sitem.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 80) // Adjust the size as needed
            }
            
            VStack(alignment: .leading) {
                Text(sitem.name)
                    .font(.headline)
                Text(sitem.description)
                    .font(.subheadline)
                Text(sitem.price)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
                onSelected()
            }) {
                
            }
        }
        .padding()
    }
}
