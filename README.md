# Project 3 - *Twitter Client*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **24** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **stretch** features are implemented:

- [x] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [x] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [x] User can switch between timeline, <s>mentions</s>, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [x] Autolayout on all screens not just the timeline view
- [x] Followers and following amounts for user appear in shortened form (i.e 1K, 2.6M)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):


1. More efficient ways to make tweet like and recount numbers refresh without having to recall the api requests everytime a view appears. 
2. How to add in a table view into a scrollview controller.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/8iJLYubFxC.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/Uw3E9wOjTl.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/UjgOpukQwd.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/gDMY5SmLlu.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/UFO2U0AfHr.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Ran into trouble when trying to make the tabBarViewController appear everytime the user opens the app. 
The view only appeared once the user would logout and log back in. Realized I had to change the root view
controller in each of the cases whether the user is already logged in or not.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
