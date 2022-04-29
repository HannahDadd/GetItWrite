//
//  PopulateDatabase.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 29/04/2022.
//

import Firebase

extension FirebaseSession {

	func populateDatabaseFakeData() {
		let fakeUser1 = User(id: "testUser1", displayName: "Jane Plane", bio: "I'm Jane. I like writing short stories and am currently on an anthology. When I'm not writing I'm baking or playing with my cat, Fred.", photoURL: nil, writing: "I like writing short stories, mostly about cats that can talk and wonder the forests and picnic together.", authors: ["Stephen King", "Karen McManus", "Rick Riordan"], writingGenres: ["Fantasy", "Magical Realism", "Histroical"], colour: 4)
		Firestore.firestore().collection("users").document("testUser1").setData(fakeUser1.dictionary) { (err) in }

		let fakeProject1 = Project(id: "fakeProject1", title: "Three Little Cats", text: "Once upon a time there were three little cats. They all loved to play games. They were walking along one day when the second young one, Ruper, said 'I love walks!'\n'Me too!' sang pauline, the youngest. \n'I'm  not a fan really' grumbled old Rick.\n They kept going because there was a really exciting maze ahead of them and they couldn't wait to enter it. But the maze was darka nd crows flew above them and there was a dark sky and grey cloud exactly over the maze.\n'I don't want to go in there' grumbled Rupert.\n'Don't be so dumb!' sequelead Pauline, for she had begged to visit the maze for months.\n'I'm warming up to this walk! This looks geat!' old Rick was super excited about the maze. It looked sinisiter and scary and exactly like something from the horror books he was always reading when the lights were off, suing the old torch he'd found in the garden once.\n'Ruperts too scared to go in!' teases Pauline.\n'Am not!' Ruper glared, dare he be called a scardy cat. And then all three's fate was sealed. For they had to go in now- there was no other option! Least they look like scardy cats and return to the close with their tails between their legs and- truly- that was no option at all. So they set paw into the maze...", synopsisSoFar: "", typeOfProject: "Short Story", blurb: "Three little cats off to enjoy a wonderful adventure when - uh oh- things start going unexpectdely wrong...", genres: ["Middle Grade", "Fantasy", "Magical Realism"], timestamp: Timestamp(), writerName: "Jane Plane", writerId: "testUser1", critiques: ["testUser2", "testUser3"], triggerWarnings: [])
		Firestore.firestore().collection("projects").document("fakeProject1").setData(fakeProject1.dictionary) { (err) in }

		let fakeUser2 = User(id: "testUser2", displayName: "Ron Cheesly", bio: "I'm the best writer in the world. When I'm not writing I'm abseiling down the grand caneon or flying to my holiday home in Switzerland.", photoURL: nil, writing: "I'm currently writing a memoir, its all about me and my exploits abseiling and how I came to own my holiday home. It's fantastic.", authors: ["William Shakespeare", "George Orwell", "Virginia Wolf"], writingGenres: ["Memoir", "Women's Fiction", "Short Stories"], colour: 3)
		Firestore.firestore().collection("users").document("testUser2").setData(fakeUser2.dictionary) { (err) in }

		let fakeProject2 = Project(id: "fakeProject2", title: "My Glorious Life", text: "It was on the third day of the fourth month that I was born. I always put it that way, at least, when I commenced school. My mother would call it third of April, but I had always seen it as more than that. The digits were so easily reversed you see, so I had to reverse them. It would be criminal not too.\n However, starting secondary school, I decided against this. I was called strange by many of the other children. One such child, Nancy, wouldn't leave me alone, she just kept laughing. But I didn't let it phase me, even at that tender age. I knew, then and there, I was destined for more.\nMy first business venture began at that very school. I began selling hard boiled sweets, which I brewed myself at home, to the children. It was simple really- no more complex than melted sugar and water. My mother taught me. I added food dye for extra effects.\nTwo weeks into the school year I had already sold to every child in the class. Well, except for Nancy. I refused to sell to her.\nWhat's more, my food venture was so sucessful even teachers began asking for sweets. Once I called into the heads office - so sure was I that I was in trouble - and asked to sell her a small bag of ten! I gave her eight and hoped she wasn't counting.\nI learnt an important lesson that day. If you are one of those sucessful people, like I am, the rules will never apply to you!", synopsisSoFar: "Another chapter in my wonderful life. This one follows on from my early schooling days and advancing to secondary school.", typeOfProject: "Chapter of Book", blurb: "Just another chapter in how anyone, even you, can become as successful as I am.", genres: ["Adult", "Memoir"], timestamp: Timestamp(), writerName: "Ron Cheesly", writerId: "testUser2", critiques: ["testUser1", "testUser3"], triggerWarnings: ["Only my brilliance"])
		Firestore.firestore().collection("projects").document("fakeProject2").setData(fakeProject2.dictionary) { (err) in }

		let fakeUser3 = User(id: "testUser3", displayName: "Lesley Barker", bio: "I love reading, I've published four books through self publishing and my third is about to come out. Can't wait to see my books in Waterstones one day!", photoURL: nil, writing: "I usually write cosy murder mysteries set in far off towns about rich people. I love sleuthing out a big crime!", authors: ["Agatha Christie", "Ernest Hemingway", "Maggie Steivfater"], writingGenres: ["Dystopian", "Mystery", "Thriller"], colour: 2)
		Firestore.firestore().collection("users").document("testUser3").setData(fakeUser3.dictionary) { (err) in }

		let fakeProject3 = Project(id: "fakeProject3", title: "The Mysterious death of Mrs Grey from Grey Street", text: "'What's going on here?' The policeman was the first on the scene, a stern expression and a neat tie.\n'Isn't it obvious?' The teenager next door screwed up his face in the only the way young kids can do- petulent and fed up, with a streak of joy at taking on the law.\n'Well, not really. I kindly ask an explanation.' The police officer pulled out his notebook, a flick of annoyance creasing his brow.\n'She's dead isn't she! Can't you see as much?' The teenager glared and tapped one foot.\n'Looks ok to me.' The officer mumbled at the greying face of Mrs Grey, and the pike sticking out of her chest, red running down her cardigan.\n'Looks ok?' The butcher stepped up. 'Shes dead'.\n'Alright alright! Let me take a closer look.' the officer stepps up to the body and inspected the red cardiagan, once sky blue, and the pinched face, once rosy and round. 'ok. SHe's looking peaky.'", synopsisSoFar: "", typeOfProject: "Chapter of Book", blurb: "A story about an old woman who's murdered, and the bumbling policeman who struggled to solve her murder.", genres: ["Young Adult", "Mystery", "Thriller"], timestamp: Timestamp(), writerName: "Lesley Barker", writerId: "testUser3", critiques: ["testUser1"], triggerWarnings: ["Murder", "death", "a long sharp pole"])
		Firestore.firestore().collection("projects").document("fakeProject3").setData(fakeProject3.dictionary) { (err) in }
	}

	func populateFakeReviews(project: Project) {
		let fakeCritique1 = Critique(id: "fakeCritique1", comments: ["Love this line!": 3, "Needs more words here": 5, "Great voice here": 10, "Spelling mistake": 12], overallFeedback: "Loved this story, could do with a few more cats. I think more tension as well to really make it dramatic.", critiquerId: "fakeUser1", critiquerName: "Jane Plane", critiquerProfileColour: 4, timestamp: Timestamp())
		Firestore.firestore().collection("projects").document(project.id).collection("critiques").document("fakeCritique1").setData(fakeCritique1.dictionary) { (err) in }

		let fakeCritique2 = Critique(id: "fakeCritique2", comments: ["Slow this down a bit": 1, "Good character intro here": 4, "This could be ellaborated on": 9], overallFeedback: "Great job, just needs more voice. Wasn't sure I understooad what happened at the end of the chapter.", critiquerId: "fakeUser2", critiquerName: "Ron Cheesly", critiquerProfileColour: 3, timestamp: Timestamp())
		Firestore.firestore().collection("projects").document(project.id).collection("critiques").document("fakeCritique2").setData(fakeCritique2.dictionary) { (err) in }

		let fakeCritique3 = Critique(id: "fakeCritique3", comments: ["Good intro": 1, "This doesn't make sense": 3, "This is a bit wordy": 5, "Bit confused here": 9, "I like this": 13], overallFeedback: "Could dow ith more work- the pacing was off, I didn't get the plot and wasn't sure who the main character was.", critiquerId: "fakeUser3", critiquerName: "Lesley Barker", critiquerProfileColour: 2, timestamp: Timestamp())
		Firestore.firestore().collection("projects").document(project.id).collection("critiques").document("fakeCritique3").setData(fakeCritique3.dictionary) { (err) in }
	}
}
