## Development Journey: Creating the Lightning App

🌟 **Steps to Create a Lightning App for Library Management**

🛠 **Step 1: Open "App Manager"**  
Go to Setup (⚙️ top right corner).  
In the Quick Find box, search for **App Manager**.  
Click **App Manager**.  
You'll see a list of apps.

🆕 **Step 2: Create New Lightning App**  
Click the **New Lightning App** button (top right corner).

✍️ **Step 3: Fill App Details**  
- App Name: *Library Management*  
- Developer Name: (auto-filled)  
- Description: *Mini Project for managing Library Books and Members*  
Click **Next**.

🎨 **Step 4: App Branding (Optional)**  
Choose a logo and colors if you want. (Skip or keep it simple for now.)  
Click **Next**.

🚀 **Step 5: Choose App Options**  
- Keep Standard Navigation  
- Keep all defaults  
Click **Next**.

👤 **Step 6: Assign User Profiles**  
- Available Profiles → Select **System Administrator** (add more later if needed)  
Click **Next**.

🧩 **Step 7: Select Navigation Items (Important!)**  
Add these tabs from Available Items:  
- **Books**  
- **Members**  
- **Issues**  
Click **Next** → then **Save & Finish**.

🛡️ **Step 8: Done! App Created!**  
Open the App Launcher (grid icon 🔲, top left),  
Search **Library Management**, and open your app.  

You’ll see tabs:  
📚 Books | 👤 Members | 📝 Issues  

✨ You can now add books, register members, and issue books seamlessly.

---

## Custom Objects and Fields

To build the data backbone of the app, I created three custom Salesforce objects with essential fields:

1. **Book__c**  
   - Book Name (Text)  
   - Author Name (Text)  
   - ISBN (Text)

2. **Members__c**  
   - Member Name (Text)  
   - Email (Email)  
   - Phone (Phone)

3. **Issues__c**  
   - Issue Name (Text)  
   - Issue Date (Date)  
   - Return Date (Date)  
   - Status (Picklist)  
   - Book (Lookup to Book__c)  
   - Member (Lookup to Members__c)

Each object models a core part of the library workflow, with relationships ensuring data integrity and easy navigation in the app.
## Screenshots

![Library Management - Book List](Screenshot%20(120).png)  
*Library Management App - Book List view*

![Library Management - Member Registration](Screenshot%20(121).png)  
*Member registration form*

![Library Management - Issue Book](Screenshot%20(122).png)  
*Issuing a book to a member*

![Library Management - Custom Objects](Screenshot%20(123).png)  
*Custom Objects setup*

![Library Management - Fields Setup](Screenshot%20(124).png)  
*Fields configuration for objects*

![Library Management - Apex Trigger Code](Screenshot%20(125).png)  
*Fields configuration for objects*

## 🔁 Apex Trigger — Prevent Duplicate Book Issues

This trigger ensures that the same book cannot be issued again unless it has been returned. It's a simple yet essential business rule enforced using **Apex**.

```apex
trigger CheckIssue on Issue__c (before insert) { 
    for(Issue__c issue : Trigger.new) { 
        List<Issue__c> existing = [SELECT Id FROM Issue__c 
                                   WHERE Book__c = :issue.Book__c 
                                   AND Return_Date__c = NULL]; 
        if(!existing.isEmpty()) { 
            issue.addError('Book already issued!');
        }
    }
}
