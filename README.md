# DOIT

To-Do App should allow the following operations on a todo item:

Create, Update, Read, Delete

### 🏗Object/Modal Structure

A todo item is made of:

- Title
- Description
- Priority (LOW,MEDIUM,HIGH)
- CreateDate(date of creation of the todo item)
- ModifiedDate(date of modification of the todo item)

### 🔖Requirements

- Someone can create / update a todo item by sending:

  - title
  - description
  - priority

  The date of creation & modification should be time stamped automatically when created

- All of the fields are required
- Someone can read one or many todo items
- Someone can delete a todo item
- THE DATA SHOULD BE STORED LOCALLY (app memory, app database)

### ✨Upcoming features

- Integrate with [Firestore](https://firebase.google.com/docs/firestore) where the todo items will be stored and retrieved(Having same CRUD operations working with Firebase)
- - Use of CoreData as Local Database
