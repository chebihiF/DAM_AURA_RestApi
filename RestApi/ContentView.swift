//
//  ContentView.swift
//  RestApi
//
//  Created by CHEBIHI FAYCAL on 12/9/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: GistsViewModel
    
    var body: some View {
        
        VStack {
            // Formulair : isPublic, description, ...
            Button(action: {
                viewModel.createGist(gist: Gist(isPublic: true, description: "test", files: ["text_file.txt": File(content: "Hello World")]))
            }){
                Text("Save Gist")
            }
            
            Button(action: {
                viewModel.gists()
            }){
                Text("Show Gists")
            }
            
            if (!viewModel.listGist.isEmpty){
                List{
                    ForEach(viewModel.listGist){ gist in
                        Text(gist.description)
                    }
                }
                
            }
            
            Spacer()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GistsViewModel())
    }
}

