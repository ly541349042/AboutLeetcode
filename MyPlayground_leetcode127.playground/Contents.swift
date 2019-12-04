import UIKit

/*
Input:
beginWord = "hit",
endWord = "cog",
wordList = ["hot","dot","dog","lot","log","cog"]

Output: 5

Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
return its length 5.
 */

var str = "Hello, playground"

//  status
enum WordMatchStatus {
    case fully          //every character matches
    case transformable  //only 1 character is unmatch
    case unavailable    //2 or more character is unmatch
}

let beginWord = "cet"
let endWord = "ism"
var wordList = ["kid","tag","pup","ail","tun","woo","erg","luz","brr","gay","sip","kay","per","val","mes","ohs","now","boa","cet","pal","bar","die","war","hay","eco","pub","lob","rue","fry","lit","rex","jan","cot","bid","ali","pay","col","gum","ger","row","won","dan","rum","fad","tut","sag","yip","sui","ark","has","zip","fez","own","ump","dis","ads","max","jaw","out","btu","ana","gap","cry","led","abe","box","ore","pig","fie","toy","fat","cal","lie","noh","sew","ono","tam","flu","mgm","ply","awe","pry","tit","tie","yet","too","tax","jim","san","pan","map","ski","ova","wed","non","wac","nut","why","bye","lye","oct","old","fin","feb","chi","sap","owl","log","tod","dot","bow","fob","for","joe","ivy","fan","age","fax","hip","jib","mel","hus","sob","ifs","tab","ara","dab","jag","jar","arm","lot","tom","sax","tex","yum","pei","wen","wry","ire","irk","far","mew","wit","doe","gas","rte","ian","pot","ask","wag","hag","amy","nag","ron","soy","gin","don","tug","fay","vic","boo","nam","ave","buy","sop","but","orb","fen","paw","his","sub","bob","yea","oft","inn","rod","yam","pew","web","hod","hun","gyp","wei","wis","rob","gad","pie","mon","dog","bib","rub","ere","dig","era","cat","fox","bee","mod","day","apr","vie","nev","jam","pam","new","aye","ani","and","ibm","yap","can","pyx","tar","kin","fog","hum","pip","cup","dye","lyx","jog","nun","par","wan","fey","bus","oak","bad","ats","set","qom","vat","eat","pus","rev","axe","ion","six","ila","lao","mom","mas","pro","few","opt","poe","art","ash","oar","cap","lop","may","shy","rid","bat","sum","rim","fee","bmw","sky","maj","hue","thy","ava","rap","den","fla","auk","cox","ibo","hey","saw","vim","sec","ltd","you","its","tat","dew","eva","tog","ram","let","see","zit","maw","nix","ate","gig","rep","owe","ind","hog","eve","sam","zoo","any","dow","cod","bed","vet","ham","sis","hex","via","fir","nod","mao","aug","mum","hoe","bah","hal","keg","hew","zed","tow","gog","ass","dem","who","bet","gos","son","ear","spy","kit","boy","due","sen","oaf","mix","hep","fur","ada","bin","nil","mia","ewe","hit","fix","sad","rib","eye","hop","haw","wax","mid","tad","ken","wad","rye","pap","bog","gut","ito","woe","our","ado","sin","mad","ray","hon","roy","dip","hen","iva","lug","asp","hui","yak","bay","poi","yep","bun","try","lad","elm","nat","wyo","gym","dug","toe","dee","wig","sly","rip","geo","cog","pas","zen","odd","nan","lay","pod","fit","hem","joy","bum","rio","yon","dec","leg","put","sue","dim","pet","yaw","nub","bit","bur","sid","sun","oil","red","doc","moe","caw","eel","dix","cub","end","gem","off","yew","hug","pop","tub","sgt","lid","pun","ton","sol","din","yup","jab","pea","bug","gag","mil","jig","hub","low","did","tin","get","gte","sox","lei","mig","fig","lon","use","ban","flo","nov","jut","bag","mir","sty","lap","two","ins","con","ant","net","tux","ode","stu","mug","cad","nap","gun","fop","tot","sow","sal","sic","ted","wot","del","imp","cob","way","ann","tan","mci","job","wet","ism","err","him","all","pad","hah","hie","aim","ike","jed","ego","mac","baa","min","com","ill","was","cab","ago","ina","big","ilk","gal","tap","duh","ola","ran","lab","top","gob","hot","ora","tia","kip","han","met","hut","she","sac","fed","goo","tee","ell","not","act","gil","rut","ala","ape","rig","cid","god","duo","lin","aid","gel","awl","lag","elf","liz","ref","aha","fib","oho","tho","her","nor","ace","adz","fun","ned","coo","win","tao","coy","van","man","pit","guy","foe","hid","mai","sup","jay","hob","mow","jot","are","pol","arc","lax","aft","alb","len","air","pug","pox","vow","got","meg","zoe","amp","ale","bud","gee","pin","dun","pat","ten","mob"]
let everyWordLength = beginWord.count
//var outputSteps: Int = 0
//var minimumOutputSteps: Int = 0
//var status = WordMatchStatus.fully

extension String {
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

func compareForTransformable(word1: String, word2: String) -> Bool {
    var matchCount = 0
    for i in 0..<everyWordLength {
        if word1[i] == word2[i] {
            matchCount += 1
        }
    }
    if matchCount == everyWordLength - 1 {
        return true
    }
    return false
}

func generateNextArray(inputArray: [[String]]) -> [[String]] {
    var outputArray = [[String]]()
    for word in wordList {
        for var tempArray in inputArray {
            let tempArrayLast = tempArray.last!
            if compareForTransformable(word1: word, word2: tempArrayLast) {
                if !tempArray.contains(word) {
                    tempArray.append(word)
                    outputArray.append(tempArray)
                }
            }
        }
    }
    return outputArray
}

func containsEndWord(result: [[String]]) -> (Bool, Int) {
    for resultArray in result {
        if resultArray.contains(endWord) {
            return (true, resultArray.count)
        }
    }
    return (false, 0)
}

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    //  if endWord not in wordList, reutrn 0 directly.
    if !wordList.contains(endWord) { return 0 }
    var result = [[String]]()
    result = generateNextArray(inputArray: [[beginWord]])
    while containsEndWord(result: result).0 == false {
        let resultCountBefore = result.first?.count
        result = generateNextArray(inputArray: result)
        let resultCountAfter = result.first?.count
        //  no answer....
        if resultCountAfter == resultCountBefore {
            return 0
        }
    }
    return containsEndWord(result: result).1
}


ladderLength(beginWord, endWord, wordList)




























////  tranformable or not
//func isTransformable(inputString: String) -> (WordMatchStatus, String?) {
//    print("------------------")
//    print(inputString)
//    print(wordList)
////    if wordList.contains(inputString) {
////        return (.fully, inputString)
////    }
//    var matchGroups = [String]()
//    for word in wordList {
//        var matchCount = 0
//        for i in 0..<everyWordLength {
//            print(inputString[i])
//            print(word[i])
//            if inputString[i] == word[i] {
//                matchCount += 1
//            }
//        }
////        print(wordList)
////        if matchCount == everyWordLength {
////            return (.fully, word)
////        }
//        //  everywordlength = 3
//        //  matchcount == 2 or 3
//        if everyWordLength - 1 <= matchCount {
////            print(word)
//            matchGroups.append(word)
//            wordList.removeAll{ $0 == word }
////            return (.transformable, word)
//        }
//        print("====")
//        print(matchGroups)
//        if matchGroups.contains(inputString) { return (.fully, inputString) }
//        return (.transformable, matchGroups.first)
//    }
//    return (.unavailable, nil)
//}
//
//func work() -> Int {
//    var result: (WordMatchStatus, String?)
//    result = isTransformable(inputString: beginWord)
//    outputSteps += 1
//    while result.0 != .unavailable {
////        if result.1! == endWord {
////            return outputSteps
////        }
////        print(result.1!)
//        if result.0 == .fully {
//            return outputSteps
//        }
//        outputSteps += 1
//        result = isTransformable(inputString: result.1!)
//    }
////    if result.0 == .fully { return outputSteps }
//    return 0
//}
//
//print(work())

//  loop to find next to final
//class Solution {
//    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
//        //  if endWord not in wordList, reutrn 0 directly.
//        if !wordList.contains(endWord) { return 0 }
//        return 0
//    }
//}
