# Buckethaca
## An app that allows Cornell students to browse, bookmark, and post about upcoming Ithaca events as well as view and checkoff Cornellian-related bucket list items.

**### Backend Repository: https://github.com/chuchutran/hack-challenge**

# Log in Page, with Google Auth
![image](https://user-images.githubusercontent.com/100049615/167276207-f0e3fb9f-b630-4d3a-897b-e2dd34534033.png)

# Main Page with Events Displayed
![image](https://user-images.githubusercontent.com/100049615/167276171-b34b8d80-edc6-4f5c-9c89-09a818c34d63.png)

# Specific Event View, presents a description
![image](https://user-images.githubusercontent.com/100049615/167276198-5bc66666-4b63-407f-bbdd-8a5da101d1ae.png)

# Post about an event, including it's name, description, date, and attach a photo!
![image](https://user-images.githubusercontent.com/100049615/167276259-e5a77c63-e9c1-45b2-b79d-ad31be5e3a24.png)

# View events that have been bookmarked or "hearted
![image](https://user-images.githubusercontent.com/100049615/167276216-b72d9e8c-0264-414e-ae39-798b11ee7a56.png)

# Bucketlist tab, where users can view bucket list items they've completed and check off new ones that they've completed already

# Random event gen! Presents a random event where users can choose to heart the event or skip to a next random event.
![image](https://user-images.githubusercontent.com/100049615/167276308-075dd001-95be-4faf-84b3-5133774e2381.png)

# Log out page
![image](https://user-images.githubusercontent.com/100049615/167276348-57a10a54-ddd9-4c3a-974b-dc3dbd78568e.png)
# Description

After logging in with Google Auth, users can browse events upcoming Cornell and Ithaca related events in various ways. There are two filtering options implemented, one being the UICollectionView horizontal scroll bar that filters events by category, and the other being the search bar at the very top. If users would like to share an upcoming event, they can post about them using the post button, where they can attach a photo of the event as well. Users can also view their bucketlist and check off things they've done already. The random event generator allows users to be view random events and see if they might be interested in any of them. 

**# Requirements**
1. Used both NSLayoutConstraint and Snapkit
2. 3 TableViews, 1 CollectionView (Filter Bar, used the same Cell in both filtering when posting events, and picking a category when posting an event)
3. UITabBarController with 5 tabs
4. Get + Post requests for viewing, posting, bookmarking events

I ran out of time to implement some of the features that were supposed to be done via networking. 
