INCLUDE Irvine32.inc

.data
    ; Welcome Messages
    welcomeMsg BYTE "Welcome to Library Management System", 0
    welcomeMsg2 BYTE "Property of FAST-NUCES", 0
    welcomeMsg3 BYTE "Made by Alisha and Layyana", 0
    divider BYTE "----------------------------------------", 0

    ; Main Menu Options
    mainMenu BYTE "Select User Type:", 0
    option1 BYTE "1. Librarian", 0
    option2 BYTE "2. Customer", 0
    option3 BYTE "3. Exit", 0
    choicePrompt BYTE "Enter your choice: ", 0

    ; Librarian Menu Options
    librarianMenuTitle BYTE "Librarian Menu:", 0
    libOption1 BYTE "1. Add Book", 0
    libOption2 BYTE "2. Update Book", 0
    libOption3 BYTE "3. Display All Books", 0
    libOption4 BYTE "4. Register Student", 0
    libOption5 BYTE "5. Back to Main Menu", 0

    ; Customer Menu Options
    customerMenuStr BYTE "Customer Menu:", 0
    custOption1 BYTE "1. Issue Book", 0
    custOption2 BYTE "2. Return Book", 0
    custOption3 BYTE "3. View Issued Books", 0
    custOption4 BYTE "4. Back to Main Menu", 0

    ; Book Management
    bookTitlePrompt BYTE "Enter Book Title: ", 0
    bookAuthorPrompt BYTE "Enter Book Author: ", 0
    bookISBNPrompt BYTE "Enter Book ISBN: ", 0
    bookQuantityPrompt BYTE "Enter Book Quantity: ", 0
    bookAddedMsg BYTE "Book added successfully!", 0
    bookNotFoundMsg BYTE "Book not found!", 0
    bookUpdatedMsg BYTE "Book information updated successfully!", 0
    noCopiesMsg BYTE "No copies available!", 0
    bookIssuedMsg BYTE "Book issued successfully!", 0
    bookReturnedMsg BYTE "Book returned successfully!", 0

    ; Student Management
    studentIDPrompt BYTE "Enter Student ID: ", 0
    studentNamePrompt BYTE "Enter Student Name: ", 0
    studentRegisteredMsg BYTE "Student registered successfully!", 0
    studentNotFoundMsg BYTE "Student not found!", 0
    studentExistsMsg BYTE "Student ID already exists!", 0

    ; Error Messages
    invalidChoiceMsg BYTE "Invalid choice! Please try again.", 0
    exitMsg BYTE "Thank you for using the Library Management System!", 0
    maxBooksMsg BYTE "Maximum number of books reached!", 0
    noBooksMsg BYTE "No books in the library!", 0
    maxStudentsMsg BYTE "Maximum number of students reached!", 0
    noIssuedBooksMsg BYTE "No books currently issued!", 0
    bookAlreadyIssuedMsg BYTE "Book is already issued!", 0
    bookNotIssuedMsg BYTE "Book is not issued!", 0

    ; Constants
    MAX_BOOKS = 50
    MAX_STUDENTS = 50
    MAX_NAME_LENGTH = 50

    ; Book Data Structure
    ALIGN 4
    BookTitles BYTE 2500 DUP(0)
    BookAuthors BYTE 2500 DUP(0)
    BookISBNs DWORD 50 DUP(0)
    BookQuantities DWORD 50 DUP(0)
    BookIssuedTo DWORD 50 DUP(0)

    ; Student Data Structure
    ALIGN 4
    StudentIDs DWORD 50 DUP(0)
    StudentNames BYTE 2500 DUP(0)
    StudentBooksIssued DWORD 50 DUP(0)

    ; Counters
    BookCount DWORD 0
    StudentCount DWORD 0

    ; Temporary Variables
    tempBuffer BYTE 50 DUP(0)
    tempID DWORD ?
    tempQuantity DWORD ?

.code
main PROC
    call Clrscr
    call DisplayWelcomeScreen

    MainMenuLoop:
        call DisplayMainMenu
        call ReadInt
        cmp eax, 1
        je LibrarianSection
        cmp eax, 2
        je CustomerSection
        cmp eax, 3
        je ExitProgram
        jmp InvalidChoice

    LibrarianSection:
        call LibrarianMenuProc
        jmp MainMenuLoop

    CustomerSection:
        call CustomerMenu
        jmp MainMenuLoop

    InvalidChoice:
        mov edx, OFFSET invalidChoiceMsg
        call WriteString
        call Crlf
        jmp MainMenuLoop

    ExitProgram:
        mov edx, OFFSET exitMsg
        call WriteString
        call Crlf
        exit
main ENDP

DisplayWelcomeScreen PROC
    mov eax, 0Eh                ; Yellow
    call SetTextColor
    mov edx, OFFSET welcomeMsg
    call WriteString
    call Crlf
    mov edx, OFFSET welcomeMsg2
    call WriteString
    call Crlf
    mov edx, OFFSET welcomeMsg3
    call WriteString
    call Crlf
    mov edx, OFFSET divider
    call WriteString
    call Crlf
    call Crlf
    mov eax, 07h                ; Reset to White
    call SetTextColor
    ret
DisplayWelcomeScreen ENDP

DisplayMainMenu PROC
    mov eax, 0Ah                ; Green
    call SetTextColor
    mov edx, OFFSET mainMenu
    call WriteString
    call Crlf
    mov edx, OFFSET option1
    call WriteString
    call Crlf
    mov edx, OFFSET option2
    call WriteString
    call Crlf
    mov edx, OFFSET option3
    call WriteString
    call Crlf
    mov edx, OFFSET choicePrompt
    call WriteString
    mov eax, 07h                ; Reset to White
    call SetTextColor
    ret
DisplayMainMenu ENDP

LibrarianMenuProc PROC
    LibrarianMenuLoop:
        mov eax, 0Ah            ; Green
        call SetTextColor
        mov edx, OFFSET librarianMenuTitle
        call WriteString
        call Crlf
        mov edx, OFFSET libOption1
        call WriteString
        call Crlf
        mov edx, OFFSET libOption2
        call WriteString
        call Crlf
        mov edx, OFFSET libOption3
        call WriteString
        call Crlf
        mov edx, OFFSET libOption4
        call WriteString
        call Crlf
        mov edx, OFFSET libOption5
        call WriteString
        call Crlf
        mov edx, OFFSET choicePrompt
        call WriteString
        mov eax, 07h            ; Reset to White
        call SetTextColor
        call ReadInt

        cmp eax, 1
        je AddBook
        cmp eax, 2
        je UpdateBook
        cmp eax, 3
        je DisplayAllBooks
        cmp eax, 4
        je RegisterStudent
        cmp eax, 5
        je ReturnToMain
        jmp InvalidLibrarianChoice

    AddBook:
        call AddNewBook
        jmp LibrarianMenuLoop

    UpdateBook:
        call UpdateBookInfo
        jmp LibrarianMenuLoop

    DisplayAllBooks:
        call ShowAllBooks
        jmp LibrarianMenuLoop

    RegisterStudent:
        call RegisterNewStudent
        jmp LibrarianMenuLoop

    InvalidLibrarianChoice:
        mov edx, OFFSET invalidChoiceMsg
        call WriteString
        call Crlf
        jmp LibrarianMenuLoop

    ReturnToMain:
        ret
LibrarianMenuProc ENDP

CustomerMenu PROC
    call CustomerLogin
    cmp eax, 0
    je ReturnToMain

    CustomerMenuLoop:
        mov eax, 0Ah            ; Green
        call SetTextColor
        mov edx, OFFSET customerMenuStr
        call WriteString
        call Crlf
        mov edx, OFFSET custOption1
        call WriteString
        call Crlf
        mov edx, OFFSET custOption2
        call WriteString
        call Crlf
        mov edx, OFFSET custOption3
        call WriteString
        call Crlf
        mov edx, OFFSET custOption4
        call WriteString
        call Crlf
        mov edx, OFFSET choicePrompt
        call WriteString
        mov eax, 07h            ; Reset to White
        call SetTextColor
        call ReadInt

        cmp eax, 1
        je IssueBook
        cmp eax, 2
        je ReturnBook
        cmp eax, 3
        je ViewIssuedBooks
        cmp eax, 4
        je ReturnToMain
        jmp InvalidCustomerChoice

    IssueBook:
        call IssueNewBook
        jmp CustomerMenuLoop

    ReturnBook:
        call ReturnIssuedBook
        jmp CustomerMenuLoop

    ViewIssuedBooks:
        call DisplayIssuedBooks
        jmp CustomerMenuLoop

    InvalidCustomerChoice:
        mov edx, OFFSET invalidChoiceMsg
        call WriteString
        call Crlf
        jmp CustomerMenuLoop

    ReturnToMain:
        ret
CustomerMenu ENDP

AddNewBook PROC
    ; Check if we have space for new book
    mov eax, BookCount
    cmp eax, MAX_BOOKS
    jge NoSpaceForBook

    ; Get book title
    mov edx, OFFSET bookTitlePrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    ; Store book title
    mov esi, BookCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET BookTitles
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    ; Get book author
    mov edx, OFFSET bookAuthorPrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    ; Store book author
    mov esi, BookCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET BookAuthors
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    ; Get book ISBN
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov esi, BookCount
    mov [BookISBNs + esi * 4], eax

    ; Get book quantity
    mov edx, OFFSET bookQuantityPrompt
    call WriteString
    call ReadInt
    mov esi, BookCount
    mov [BookQuantities + esi * 4], eax

    ; Initialize issued status
    mov esi, BookCount
    mov [BookIssuedTo + esi * 4], 0

    ; Increment book count
    inc BookCount

    ; Display success message
    mov edx, OFFSET bookAddedMsg
    call WriteString
    call Crlf
    ret

    NoSpaceForBook:
        mov edx, OFFSET maxBooksMsg
        call WriteString
        call Crlf
        ret
AddNewBook ENDP

UpdateBookInfo PROC
    ; Get ISBN of book to update
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    ; Search for book
    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    ; Book not found
    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        ; Get new quantity
        mov edx, OFFSET bookQuantityPrompt
        call WriteString
        call ReadInt
        mov [BookQuantities + esi * 4], eax

        ; Display success message
        mov edx, OFFSET bookUpdatedMsg
        call WriteString
        call Crlf
        ret
UpdateBookInfo ENDP

ShowAllBooks PROC
    mov ecx, BookCount
    mov esi, 0
    cmp ecx, 0
    je NoBooks

    DisplayLoop:
        ; Display book title
        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookTitles
        add edx, eax
        call WriteString
        call Crlf

        ; Display book author
        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookAuthors
        add edx, eax
        call WriteString
        call Crlf

        ; Display book ISBN
        mov eax, [BookISBNs + esi * 4]
        call WriteInt
        call Crlf

        ; Display book quantity
        mov eax, [BookQuantities + esi * 4]
        call WriteInt
        call Crlf

        call Crlf
        inc esi
        loop DisplayLoop
    ret

    NoBooks:
        mov edx, OFFSET noBooksMsg
        call WriteString
        call Crlf
        ret
ShowAllBooks ENDP

RegisterNewStudent PROC
    ; Check if maximum students reached
    mov eax, StudentCount
    cmp eax, MAX_STUDENTS
    jl canRegister

    mov edx, OFFSET maxStudentsMsg
    call WriteString
    call Crlf
    ret

canRegister:
    ; Get student ID
    mov edx, OFFSET studentIDPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    ; Check for duplicate ID
    mov ecx, StudentCount
    mov esi, 0
checkDupLoop:
    cmp ecx, 0
    je storeStudent
    mov eax, [StudentIDs + esi * 4]
    cmp eax, tempID
    je IDExists
    inc esi
    dec ecx
    jmp checkDupLoop

storeStudent:
    ; Store student ID
    mov esi, StudentCount
    mov eax, tempID
    mov [StudentIDs + esi * 4], eax

    ; Get student name
    mov edx, OFFSET studentNamePrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    ; Store student name
    mov esi, StudentCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET StudentNames
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    ; Initialize books issued count
    mov esi, StudentCount
    mov [StudentBooksIssued + esi * 4], 0

    ; Increment student count
    inc StudentCount

    ; Display success message
    mov edx, OFFSET studentRegisteredMsg
    call WriteString
    call Crlf
    ret

IDExists:
    mov edx, OFFSET studentExistsMsg
    call WriteString
    call Crlf
    ret
RegisterNewStudent ENDP

CustomerLogin PROC
    ; Get student ID
    mov edx, OFFSET studentIDPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    ; Check if any students are registered
    mov eax, StudentCount
    cmp eax, 0
    je NoStudentsRegistered

    ; Search for student
    mov ecx, StudentCount
    mov esi, 0
    SearchLoop:
        mov eax, [StudentIDs + esi * 4]
        cmp eax, tempID
        je StudentFound
        inc esi
        loop SearchLoop

    ; Student not found
    mov edx, OFFSET studentNotFoundMsg
    call WriteString
    call Crlf
    mov eax, 0
    ret

    NoStudentsRegistered:
        mov edx, OFFSET studentNotFoundMsg
        call WriteString
        call Crlf
        mov eax, 0
        ret

    StudentFound:
        mov eax, 1
        ret
CustomerLogin ENDP

IssueNewBook PROC
    ; Get book ISBN
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    ; Search for book
    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    ; Book not found
    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        ; Check if book is available
        mov eax, [BookQuantities + esi * 4]
        cmp eax, 0
        jle NoCopiesAvailable

        ; Check if book is already issued
        mov eax, [BookIssuedTo + esi * 4]
        cmp eax, 0
        jne BookAlreadyIssued

        ; Issue the book
        mov eax, tempID
        mov [BookIssuedTo + esi * 4], eax
        dec [BookQuantities + esi * 4]

        ; Display success message
        mov edx, OFFSET bookIssuedMsg
        call WriteString
        call Crlf
        ret

    NoCopiesAvailable:
        mov edx, OFFSET noCopiesMsg
        call WriteString
        call Crlf
        ret

    BookAlreadyIssued:
        mov edx, OFFSET bookAlreadyIssuedMsg
        call WriteString
        call Crlf
        ret
IssueNewBook ENDP

ReturnIssuedBook PROC
    ; Get book ISBN
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    ; Search for book
    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    ; Book not found
    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        ; Check if book is issued
        mov eax, [BookIssuedTo + esi * 4]
        cmp eax, 0
        je BookNotIssued

        ; Return the book
        mov [BookIssuedTo + esi * 4], 0
        inc [BookQuantities + esi * 4]

        ; Display success message
        mov edx, OFFSET bookReturnedMsg
        call WriteString
        call Crlf
        ret

    BookNotIssued:
        mov edx, OFFSET bookNotIssuedMsg
        call WriteString
        call Crlf
        ret
ReturnIssuedBook ENDP

DisplayIssuedBooks PROC
    mov ecx, BookCount
    mov esi, 0
    cmp ecx, 0
    je NoIssuedBooks

    DisplayLoop:
        mov eax, [BookIssuedTo + esi * 4]
        cmp eax, 0
        je NextBook

        ; Display book title
        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookTitles
        add edx, eax
        call WriteString
        call Crlf

        ;disp book author
        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookAuthors
        add edx, eax
        call WriteString
        call Crlf

        ; Display book ISBN
        mov eax, [BookISBNs + esi * 4]
        call WriteInt
        call Crlf

        call Crlf

    NextBook:
        inc esi
        loop DisplayLoop
    ret

    NoIssuedBooks:
        mov edx, OFFSET noIssuedBooksMsg
        call WriteString
        call Crlf
        ret
DisplayIssuedBooks ENDP

END main
