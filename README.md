# Postly

Postly a social app that lets you share your thoughts and get comments from the community.

## Getting Started

**Install Packages**\
To install packages run **flutter pub get** on the console/terminal

**Working Screenshot**\
This is a working sample of the home screen of Postly
The user's points for creating a new post is displayed beside their username as well as their level which is determined by their point. The levels include
1. Less than 6 points : Beginner 
2. Less than 10 points: Intermediate
3. 10 to 16 points and above: Professional\
A user can also create a new post by clicking on the **Create Post** floating action button\
<img alt="Screenshot of the home screen" src="https://drive.google.com/uc?export=view&id=1wzNPnO6H_ujdz9AqzDaHT_K10I_OpUjP" width="600">\

After a user clicks the **Create Post** floating action button the user is taken to the "Create Post" screen where the user can then input the title and body of their desired new post\
**NOTE:** The user should ensure to not leave either the **Title** or **Body** textfields empty as this will prompt a toast message notifying them to input text into the empty fields\

After creating the post, the user can either choose to publish their new post by clicking on the **Post** button or cancel publishing the new post by clicking on the **Cancel** button
![Screenshot of the create post screen](https://drive.google.com/uc?export=view&id=1Fn0j8Yf4h3QUa_rhU-b2R3ypDKytllWr) 

For every post a user creates and post, their accrued points is increased by 2 which is displayed on the home screen beside their username *please refer to the first screenshot*. When a user has accrued more than 16 points, when the app is initially launched, the user gets a dialog message **You are a legend** to notify them of their achievement and on dismissal of the message their point reverts back to 0
![Screenshot of the dialog message](https://drive.google.com/uc?export=view&id=1ExVctbigfeH7E0G_udKia4S_Zj08LJR5)
