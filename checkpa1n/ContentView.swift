//
//  ContentView.swift
//  checkpa1n
//
//  Created by Toby Fox on 22/10/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var triggerRespring: Bool
    @State var cydiadownload = false
    @State private var showingAlert = false
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    VStack {
                        if colorScheme == .dark{
                            Image("pa1n")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.leading, -70.0)
                        }
                        if colorScheme == .light{
                            Image("check")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.leading, -70.0)
                        }
                        
                        Text("Loader")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }.padding(.leading, 20.0)
                    Spacer()
                }
                Spacer()
                
                VStack{
                    List {
                        NavigationLink(destination: View2()){
                            Image("sidia").resizable()
                                .frame(width:30, height: 30)
                            Text("Cydia")
                        }.navigationBarBackButtonHidden(true)
                    
                    }
                    .frame(height: 75.0)
                    .frame( maxWidth: .infinity)
                        
                        .edgesIgnoringSafeArea(.all)
                        .listStyle(GroupedListStyle())
                    List{
                        
                        Button(action:{
                            showingAlert = true
                        }, label:{Text("Restore System").foregroundColor(Color.red)})
                        
                    }.frame( maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .listStyle(GroupedListStyle())
                        .alert(isPresented: $showingAlert){
                            Alert(
                                title: Text("Restore System"),
                                message: Text("This will uninstall the jailbreak and remove any associated files."),
                                primaryButton: .destructive(Text("Restore System"), action: {
                                    respring()
                                }),
                                secondaryButton: .default(Text("Cancel"), action: {
                                    print("troll")
                                }
                                                         )
                            )

                        }
                }
                
            }
        }.navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
    
    func respring() {
        withAnimation(.easeInOut) {
            triggerRespring = true
        }
    }
}


struct View2: View {
    @Environment(\.presentationMode) var presentation
    @State var progresstext = "Downloading Cydia.deb"
    @State var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView{
            VStack{
                ProgressView("\(progresstext)").onReceive(timer) {
                    _ in if timeRemaining < 22 {
                        progresstext = "Running dpkg"
                    }
                    if timeRemaining < 11 {
                        progresstext = "Installing Cydia"
                    }
                    if timeRemaining == 0 {
                        self.presentation.wrappedValue.dismiss()
                    }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            }
        }.navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
    }
    
}

struct View3: View {
    @Binding var triggerRespring: Bool
    @Environment(\.presentationMode) var presentation
    var balls = true
    var body: some View {
        NavigationView {
            Text(" ").onAppear{
                respring()
            }
            
        }.navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
    }
    
    func respring() {
        withAnimation(.easeInOut) {
            triggerRespring = true
        }
    }

    
}



    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(triggerRespring: .constant(false))
        }
    }

