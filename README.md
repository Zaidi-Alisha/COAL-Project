# Library Management System

## Overview  
This is a Library Management System implemented in Assembly Language (x86) using the Irvine32 library. The system provides different functionalities for librarians and students, allowing them to manage books and track book issuances.  

## Features:  

### Main Menu  
- Select user type (Librarian or Student)  
- Exit the system  

### Librarian Functions  
1. **Add Book**: Add a new book to the library with title, author, ISBN, and quantity  
2. **Update Book**: Modify the quantity of an existing book  
3. **Display All Books**: View all books in the library  
4. **Register Student**: Add a new student to the system  
5. **Back to Main Menu**: Return to the main selection screen  

### Student Functions  
1. **Issue Book**: Check out a book from the library  
2. **Return Book**: Return a previously issued book  
3. **View Issued Books**: See all currently issued books  
4. **Back to Main Menu**: Return to the main selection screen  

---

## Data Structures  
- **Books**: Stores title, author, ISBN, quantity, and issued status  
- **Students**: Stores student ID, name, and books issued count  

---

## System Requirements  
- MASM (Microsoft Macro Assembler)  
- Irvine32 library  
- Windows operating system  

---

## Limitations  
- Maximum of 50 books and 50 students  
- Book titles and student names limited to 50 characters  
- Simple text-based interface  
- No persistent storage (data is lost when program exits)  

---

## Project Information  
- **Course**: Computer Organization and Assembly Language (COAL)  
- **Developed by**: Alisha and Layyana  
- **Institution**: FAST-NUCES  

---

## Notes  
- The system uses color coding (green for menus, yellow for welcome screen)  
- All input/output is console-based  
- Error handling is included for invalid choices and edge cases  
