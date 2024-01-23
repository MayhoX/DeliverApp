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
        NavigationView {
            List(sitems) { sitem in
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
        NavigationLink(destination: SItemDetailView(sitem: sitem)) {
            HStack {
                if let uiImage = UIImage(data: sitem.image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 80) 
                }

                VStack(alignment: .leading) {
                    Text(sitem.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(sitem.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(sitem.type)
                        .font(.subheadline)
                    
                    Text("$\(sitem.price)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }

                Spacer()

                
            }
            .padding()
        }
    }
}
