# Buckethaca
## An app that allows Cornell students to browse, bookmark, and post about upcoming Ithaca events as well as view and checkoff Cornellian-related bucket list items.

### Backend Repository: https://github.com/chuchutran/hack-challenge

# Log in Page, with Google Auth
<img width="363" alt="image" src="https://user-images.githubusercontent.com/100049615/167527176-7ac60cff-9805-4974-9c3e-19bb7c351ea6.png">

# Main Page with Events Displayed
<img width="365" alt="image" src="https://user-images.githubusercontent.com/100049615/167527223-d582a84e-5abd-4b8d-8a99-40e90fe6f160.png">


# Specific Event View, presents a description
<img width="366" alt="image" src="https://user-images.githubusercontent.com/100049615/167527252-a66901d3-79b2-4138-9ef5-d8edc9310d34.png">


# Post about an event, including it's name, description, date, and attach a photo!
<img width="369" alt="image" src="https://user-images.githubusercontent.com/100049615/167527303-d377b8a4-d32c-4996-a8be-7e7715e789da.png">


# View events that have been bookmarked or "hearted
<img width="357" alt="image" src="https://user-images.githubusercontent.com/100049615/167527340-bfc67113-bb0c-49a6-a6c6-0b5e882ff536.png">


# Bucketlist tab, where users can view bucket list items they've completed and check off new ones that they've completed already
<img width="356" alt="image" src="https://user-images.githubusercontent.com/100049615/167527364-6696378e-89db-4c37-9a29-2e986976e7c6.png">


# Random event gen! Presents a random event where users can choose to heart the event or skip to a next random event.
<img width="376" alt="image" src="https://user-images.githubusercontent.com/100049615/167527390-d51f1e84-9128-4dc3-9d9f-09910db6bb4f.png">


# Log out page
<img width="364" alt="image" src="https://user-images.githubusercontent.com/100049615/167527417-9ac5fb58-3dc1-467a-9a79-6507f470e541.png">

# Description

After logging in with Google Auth, users can browse events upcoming Cornell and Ithaca related events in various ways. There are two filtering options implemented, one being the UICollectionView horizontal scroll bar that filters events by category, and the other being the search bar at the very top. If users would like to share an upcoming event, they can post about them using the post button, where they can attach a photo of the event as well. Users can also view their bucketlist and check off things they've done already. The random event generator allows users to be view random events and see if they might be interested in any of them. 

# Requirements
1. Used both NSLayoutConstraint and Snapkit
2. 3 TableViews, 1 CollectionView (Filter Bar, used the same Cell in both filtering when posting events, and picking a category when posting an event)
3. UITabBarController with 5 tabs
4. Get + Post requests for viewing, posting, bookmarking events

I ran out of time to implement some of the features that were supposed to be done via networking. 
