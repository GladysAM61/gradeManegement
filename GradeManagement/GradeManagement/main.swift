//
//  main.swift
//  GradeManagement
//
//  Created by StudentAM on 1/26/24.
//

import Foundation
import CSV

//put variab
//creating an array storing the names
var names: [String] = []
//creating an array storing all of the students grades
var grades: [[String]] = []
var finalGradess: [Double] = []

//grabbing the file with all the data
//doing this by using a do statement
do{
//    picking the grade file
    let stream = InputStream(fileAtPath: "/users/studentAM/Desktop/grades.csv")
//creating a csvReader to grab data from the file
    let csv = try CSVReader(stream: stream!)
//creating a while loop to grab the data from the stream
    while let row = csv.next(){
//        print()
        manageData(data:row)
    }
}
catch{
   print("wrong")
}


//var averageGradee = Int(grades) / 8
//
//var gradeNumber = String(format: Int(grades),grades)

//array name is data
func manageData( data : [String]){
//    print(data[0])
//creating a variable to hold the row of array
    var tempGrades: [String] = []
//    creating a for loop to append the indices

   for i in data.indices{
      if i==0{
            names.append(data[i])
        }
      else{
           tempGrades.append(data[i])
            
        }
    }
    grades.append(tempGrades)
    displayGradeForOne(grades: tempGrades)
}

//creating a function to print out the questions
func startingQuestions(){
    print("Welcome to the Grade Manager! What would you like to do today?")
    print("0.) Display a grade for a student")
    print("1.) Display all grades for a student")
    print("2.) Display all grades for all students")
    print("3.) Average of the class")
    print("4.) Average of an assignment")
    print("5.) Lowest grade of the class")
    print("6.) Highest grade of the class")
    print("7.) Filter students by grade range")
    print("8.) Quit")
    
    if let userInput = readLine(){
//        if the user types 0, run the display one grade function
        if userInput == "0"{
           studentGrade()
//
        }
//        if the user types 1, run the oneGrade function
        if userInput == "1"{
            oneGradeOneStudent()
        }
//    if the user types 2, run the displayAllGrades function
        if userInput == "2"{
            displayAllGrades()
        }
        if userInput == "3"{
            averageClass()
        }
        if userInput == "4"{
            assignmentAverage()
        }
        if userInput == "5"{
            lowestGrade()
        }
        if userInput == "6"{
            highestGrade()
        }
        if userInput == "7"{
            filterByGrade()
        }
        if userInput == "8"{
            quit()
        }
    }
    
}

startingQuestions()



//creating a function to display the final grades for one student
func displayGradeForOne(grades:[String]){
//    print("What student's grade would you like to print?")
//  allowing us to grab the userInput
//    if let userInput = readLine(){
        var sum: Int = 0
//    converting the strings into a int
        for everyGrade in grades{
            if let intGrades = Int(everyGrade){
//                adding all the grades in the sum string
                sum += intGrades
            }
        }
    var finalGrades = sum/grades.count
    finalGradess.append(Double(finalGrades))
}

//creating a function to display the final grade for one student
func studentGrade(){
    print("Which student's grades would you like to print?")
    if let userInput = readLine(){
        for i in names.indices{
            if names[i] == userInput{
                    print(finalGradess[i])
                return startingQuestions()
           }
        }
    }
}





//creating a function to display a grade for one student
func oneGradeOneStudent(){
    print("Which student's grades would you like to print?")
    //  allowing us to grab the userInput
    if let userInput = readLine(){
        for i in names.indices{
            if names[i] == userInput{
                for j in grades.indices{
                    //                two d array you need to go more into the array to take out the numbers
                    var newGradesString: String = grades[j].joined(separator: ", ")
                    print(newGradesString)
                    
                    //                returning to stop the for loop so it doesn't keep running
                    return startingQuestions()
                }
            }
        }
    }
}

//creating a function to diplay all of the grades
func displayAllGrades(){
//    creating a for loop to go through all the names and all the grades
    for i in names.indices{
        let allTotal = grades[i]
        let allName = names[i]
//        turning the grades not into an array
        var gradesString: String = allTotal.joined(separator: ", ")
        print("\(allName) grades are: \(gradesString)")
      }
    return startingQuestions()
}

//creating a function to average the class
func averageClass(){
    var averageGrades: Double = 0
    for average in finalGradess{
//                adding all the grades in the averageGrade variable
            averageGrades += average

    }
    var averageClassGrades = averageGrades/Double(grades.count)
//    format thing to making it only 2 decimals spaces
    print("The class average is \(String(format: "%.2f",averageClassGrades))")
    return startingQuestions()
}

//creating a function to find the average grade for one assignment
func assignmentAverage(){
    var assignmentAv: Double = 0
    var sum : Double = 0
    var userIndex: String = ""
    print("What assignment number do you want to find the average for?(1-10)")
    if let userInput = readLine(), let index = Int(userInput){
        userIndex = userInput
        for row in grades{
//            += to add to all of the sums and not just one
            if let grade = Double(row[index-1]){
                sum += grade
            }
        }
        assignmentAv = sum/Double(names.count)
    }
    print("The average for assignment \(userIndex) is: \(String(format: "%.2f",assignmentAv))")
    return startingQuestions()
}

//creating a function to find the lowest grade
func lowestGrade(){
//    creating a variable storing the first grade assuming its the lowest grade
    var lowest : Double = finalGradess[0]
//    creating an index
    var index : Int = 0
//    for loop to go through the grades and find the lowest one
            for i in finalGradess.indices{
                if finalGradess[i] < lowest{
                    lowest = finalGradess[i]
                    index = i
                }
    }
   print("\(names[index]) has the lowest grade: \(lowest)")
   return startingQuestions()
}

//function to find the highest grade
func highestGrade(){
    //    creating a variable storing the first grade assuming its the highest grade
    var highest : Double = finalGradess[0]
    //    creating an index
    var index : Int = 0
    //    for loop to go through the grades and find the highest one
    for i in finalGradess.indices{
        if finalGradess[i] > highest{
            highest = finalGradess[i]
            index = i
        }
    }
    print("\(names[index]) has the highest grade: \(highest)")
    return startingQuestions()
}
func filterByGrade(){
    print("Enter the low range you would like to use?")
//    inside the if statement to get access for both
    if let userInput = readLine(), let lowRange = Int(userInput){
        print("Enter the high range you would like to use?")
        if let userInput = readLine(), let highRange = Int(userInput){
//            checking the i in final grades
            for i in finalGradess.indices{
                if lowRange < Int(finalGradess[i]) && Int(finalGradess[i]) < highRange{
                    print("\(names[i]): \(finalGradess[i])")
                }
            }
        }
    }
    return startingQuestions()
    
}

//creating a function so they can quit the management function
func quit(){
    print("Have a great rest of your day!")
}
