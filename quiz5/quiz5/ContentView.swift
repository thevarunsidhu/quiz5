//
//  ContentView.swift
//  quiz5
//
//  Created by Varun Sidhu on 2022-03-02.
//

import SwiftUI
import Foundation

struct Post: Codable, Identifiable {
    let id = UUID()
    var activity: String
    var type: String
    
}

class Api{
    func getPosts(completion: @escaping ([Post]) -> ()){
    guard let url = URL(string: "https://www.boredapi.com/api/activity") else {return}
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}

struct ContentView: View {
    @State var posts: [Post] = []
    
    var body: some View {
        ZStack {
                    Color.purple
                        .ignoresSafeArea()
                    
                    // Your other content here
                    // Other layers will respect the safe area edges
            
        
        VStack{
            
            ZStack{
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 200, height: 100)
                
                Text("Activites")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)

            }.padding()
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(1..<5) {
                        List(posts) { post in
                        Text(post.type + "Type / $0")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: 150, height: 150,  alignment: .top)
                            .background(Color.white)
                            .onAppear{
                                Api().getPosts{(posts) in
                                    self.posts = posts
                                    
                                }
                            }
                        
                    }
                    }
                }
            }.padding()
            
            ZStack{
                
//                Rectangle()
//                    .fill(Color.white)
//                    .frame(width: 300, height: 260)
                
                Text("Activity of the day")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 260, alignment: .top)
                    .background(Color.white)
                Spacer()
                Text("[Your Activity here]")
                    .fontWeight(.medium)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
            
            
        }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

