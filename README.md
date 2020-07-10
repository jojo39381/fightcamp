## FightCamp Homework

## Please simulate on iPhone 11 Pro Max for best UI

### Summary

I first made a homeview controller since that is the only view that the user will see. Then, since the view controller just contains a collection, I decided to make it adopt the collectionview delegate and datasource and make the collection fill up the whole screen. That way it gives the developer more flexible in case they want to add more stuff to the view controller outside of the collectionview.

Inside the Package Collection View there is another collection that contains the small thumbnail images. It also has a table view controller that contains the list of things that are included and excluded.

I got all the data by using a manager that I made to separate the function from the view, then I store all the data I got from the json file into a data model called Package Model, and then finally I use a delegate method to pass that model back to the view controller. 

Inside the Package Model is a list of Packages, which is a struct I created that contains the package details.

I think that makes it really organized and allows easy access to the package information.


## Missing & More Information

I used the height constants given, but I was on why I was given those constants. The 240 height of the big thumbnail looks weird on smaller iphones, and the text sizes are constant as well, so I cant change them to fit smaller phone sizes.

The only thing that is missing is that the height of some elements get distorted and the table view compresses when it is below the iPhone 11 Pro Max size, that's probably a quick fix if I can break the rules a little bit.

## I hope you like it! I really like this company and its culture! Thank you!
# fightcamp
