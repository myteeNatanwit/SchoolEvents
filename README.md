# SchoolEvents
Swift and School Event using DataModule for offline/online sync<br>
## Notes:
1-	School preset to Monash uni, Melbourne. Geolocation is school.lat = -37.896751; school.lon = 145.147141. Not yet adding screen for School. Uncertain the purpose.<br>
2-	Uncertain about payment – it is not yet done. Usually it should be done by admin side? Or participant can choose to pay byself? Then we need server for that purpose.<br>
3-	Location, is using suburb, from json.<br>
4-	Distance is calc using Mapkit, not api, for point to point with lat/lon.<br>
5-	The app is offline with SQLlite. It can sync to a server when we know the API. The idea is user can use it even offline. <br>
6-	There must be login screen for user roles: organiser, and participant to access certain screens as read only or full control respectively.<br>
# Screens
![](https://github.com/myteeNatanwit/SchoolEvents/raw/master/screens.gif)
# ER Diagram
![](https://github.com/myteeNatanwit/SchoolEvents/raw/master/er3.PNG)
# Instruction
1-	Decompress zipfile in mac, load Xcodeproj file.<br>
2-	First time, it will generate dummy data. User can add/delete the events with swipe to left.<br>
3-	Search feature works in eventlist description, location selection and category screens.<br>

# Next version
1-	School add feature. User as admin can add own school.<br>
2-	Sync with server, so the work local will b sync with server, so other clients can also access same data. Andoid/web?<br>
3-	Proper entry screens for Catergory, participate and organiser.<br>
4-	Fields validation for entry screens.<br>
5-	Feedback/msg/phone to organiser from participant.<br>
6-	Group msg/chat for ppl who participate to the event.<br>
7-	Login with different roles.<br>


