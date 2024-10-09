
import SwiftUI

struct mainPage: View {
    @State private var newTitle: String = ""
    public var userWidth = UIScreen.main.bounds.width
    public var userHeight = UIScreen.main.bounds.height
    @State private var Search: String = ""
    
    @State private var currentPageIndex: Int = 0
    @State private var addIndexPage: Int = 0
    private let inputType = ["Manual", "Scanner"]
    private let pages = ["My Recipes", "Add Recipe"]
    private let searchController = UISearchController()
    
    @State private var steps: [String] = [""]
    
    @State private var selectedSpice: String = "1"
    @State private var selectedHarware: String = "1"
    
    let numbers = ["1", "2", "3", "4", "5"]

    var body: some View {
        ScrollView{
            VStack {
                // Title and navigation area
                HStack {
                    // Spacer for layout
                    Spacer()
                    // Inactive Page - Left
                    if currentPageIndex > 0 {
                        Text(pages[currentPageIndex - 1])
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .scaleEffect(0.8)
                    }
                    Spacer()
                    // Active Page
                    Text(pages[currentPageIndex])
                        .layoutPriority(1)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1) // Ensure single line
                    Spacer()
                    // Inactive Page - Right
                    if currentPageIndex < pages.count - 1 {
                        Text(pages[currentPageIndex + 1])
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .scaleEffect(0.9)
                            .frame(alignment:.bottom)
                    }
                    
                    // Spacer for layout
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .frame(
                    width: userWidth*0.8, height: userHeight*0.1)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -100 { // swipe left
                                moveToNextPage()
                            } else if value.translation.width > 100 { // swipe right
                                moveToPreviousPage()
                            }
                        }
                )
                
                //display correct elemts depending on page. 0 = "my recipes"
                if(currentPageIndex == 0){
                    TextField("Search", text: $Search).frame(width:userWidth * 0.4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(radius: 2)
                        )
                        .padding(5)
                        .multilineTextAlignment(.center)
                    
                    List{
                        Text("Item 1")
                        Text("Item 2")
                        Text("Item 3")
                        Text("Item 4")
                        Text("Item 5")
                        Text("Item 6")
                        Text("Item 7")
                        Text("Item 8")
                    }.frame(width:userWidth * 0.85,height:userHeight * 0.55).listRowSpacing(20).scrollContentBackground(.hidden).shadow(radius: 3)
                    
                } else{
                    HStack{
                        Button("Manual") {
                            addPreviousPage()
                        }.padding(5) // Add padding around the text
                            .frame(maxWidth: userWidth * 0.3) // Optional: to make the button stretch
                            .background(Color.blue) // Background color
                            .foregroundColor(.white) // Text color
                            .cornerRadius(10)
                        Spacer()
                        Button("Scanner") {
                            addNextPage()
                        }.padding(5) // Add padding around the text
                            .frame(maxWidth: userWidth * 0.3) // Optional: to make the button stretch
                            .background(Color.blue) // Background color
                            .foregroundColor(.white) // Text color
                            .cornerRadius(10)
                        
                    }.frame(width: userWidth * 0.7)
                    if(addIndexPage == 1){
                        
                    } else{
                        Text("Title:")
                        TextField("Title", text: $newTitle).frame(width: userWidth * 0.5,height: userHeight * 0.03).border(Color.black)
                        Text("Ingredients:")
                        TextField("Ingredients", text: $newTitle).frame(width: userWidth * 0.5,height: userHeight * 0.03).border(Color.black)
                        VStack {
                                    Text("Spice Rating:")
                                    
                                    Picker("Spice Rating", selection: $selectedSpice) {
                                        ForEach(numbers, id: \.self) { number in
                                            Text(number).tag(number)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                }
                        Spacer()
                        VStack {
                                    Text("kitchen Tools:")
                                    
                                    Picker("kitchen Tools", selection: $selectedHarware) {
                                        ForEach(numbers, id: \.self) { number in
                                            Text(number).tag(number)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                }
                        
                        
                        Text("Instructions:")
                        // Dynamic TextFields for each step
                        ForEach(0..<steps.count, id: \.self) { index in
                            HStack {
                                TextField("Enter step \(index + 1)", text: $steps[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                // Button to remove step
                                if steps.count > 1 {
                                    Button(action: {
                                        removeStep(at: index)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        HStack{
                            // Button to add a new step
                            Button(action: {
                                addStep()
                            }) {
                                Text("Add Step")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                            // Save Button
                            Button(action: {
                                saveTaskSteps()
                            }) {
                                Text("Save Steps")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }.padding()
                        }
                        Button("Upload") {
                            
                        }
                        
                    }
                    
                    
                }
                
                Spacer()
                Spacer()
                
            }
        }
    }
    private func moveToNextPage() {
        if currentPageIndex < pages.count - 1 {
            currentPageIndex += 1
        }
    }
    private func moveToPreviousPage() {
        if currentPageIndex > 0 {
            currentPageIndex -= 1
        }
    }
    private func addNextPage() {
        if addIndexPage < inputType.count - 1 {
            addIndexPage += 1
        }
    }
    private func addPreviousPage() {
        if addIndexPage > 0 {
            addIndexPage -= 1
        }
    }
    private func addStep() {
        steps.append("") // Add a new empty step
    }
    
    private func removeStep(at index: Int) {
        steps.remove(at: index) // Remove the specified step
    }
    
    private func saveTaskSteps() {
        // Handle saving the task steps here
        print("Task Steps saved: \(steps)")
        // Optionally clear steps after saving
        steps = [""]
    }
}
struct mainPage_Previews: PreviewProvider {
    static var previews: some View{
        mainPage()
    }
}
