INCLUDE Irvine32.inc

.data
    welcomeMsg BYTE "Welcome to Library Management System", 0
    welcomeMsg2 BYTE "Property of FAST-NUCES", 0
    welcomeMsg3 BYTE "Made by Alisha and Layyana", 0
    divider BYTE "----------------------------------------", 0

    mainMenu BYTE "Select User Type:", 0
    option1 BYTE "1. Librarian", 0
    option2 BYTE "2. Student", 0
    option3 BYTE "3. Exit", 0
    choicePrompt BYTE "Enter your choice: ", 0

    librarianMenuTitle BYTE "Librarian Menu:", 0
    libOption1 BYTE "1. Add Book", 0
    libOption2 BYTE "2. Update Book", 0
    libOption3 BYTE "3. Display All Books", 0
    libOption4 BYTE "4. Register Student", 0
    libOption5 BYTE "5. Back to Main Menu", 0

    studentMenuStr BYTE "Student Menu:", 0
    studOption1 BYTE "1. Issue Book", 0
    studOption2 BYTE "2. Return Book", 0
    studOption3 BYTE "3. View Issued Books", 0
    studOption4 BYTE "4. Back to Main Menu", 0

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

    studentIDPrompt BYTE "Enter Student ID: ", 0
    studentNamePrompt BYTE "Enter Student Name: ", 0
    studentRegisteredMsg BYTE "Student registered successfully!", 0
    studentNotFoundMsg BYTE "Student not found!", 0
    studentExistsMsg BYTE "Student ID already exists!", 0

    invalidChoiceMsg BYTE "Invalid choice! Please try again.", 0
    exitMsg BYTE "Thank you for using the Library Management System!", 0
    maxBooksMsg BYTE "Maximum number of books reached!", 0
    noBooksMsg BYTE "No books in the library!", 0
    maxStudentsMsg BYTE "Maximum number of students reached!", 0
    noIssuedBooksMsg BYTE "No books currently issued!", 0
    bookAlreadyIssuedMsg BYTE "Book is already issued!", 0
    bookNotIssuedMsg BYTE "Book is not issued!", 0

    MAX_BOOKS = 50
    MAX_STUDENTS = 50
    MAX_NAME_LENGTH = 50

    ALIGN 4
    BookTitles BYTE 2500 DUP(0)
    BookAuthors BYTE 2500 DUP(0)
    BookISBNs DWORD 50 DUP(0)
    BookQuantities DWORD 50 DUP(0)
    BookIssuedTo DWORD 50 DUP(0)

    ALIGN 4
    StudentIDs DWORD 50 DUP(0)
    StudentNames BYTE 2500 DUP(0)
    StudentBooksIssued DWORD 50 DUP(0)

    BookCount DWORD 0
    StudentCount DWORD 0

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
        je StudentSection
        cmp eax, 3
        je ExitProgram
        jmp InvalidChoice

    LibrarianSection:
        call LibrarianMenuProc
        jmp MainMenuLoop

    StudentSection:
        call StudentMenu
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
    mov eax, 0Eh
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
    mov eax, 07h
    call SetTextColor
    ret
DisplayWelcomeScreen ENDP

DisplayMainMenu PROC
    mov eax, 0Ah
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
    mov eax, 07h
    call SetTextColor
    ret
DisplayMainMenu ENDP

LibrarianMenuProc PROC
    LibrarianMenuLoop:
        mov eax, 0Ah
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
        mov eax, 07h
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

StudentMenu PROC
    call StudentLogin
    cmp eax, 0
    je ReturnToMain

    StudentMenuLoop:
        mov eax, 0Ah
        call SetTextColor
        mov edx, OFFSET studentMenuStr
        call WriteString
        call Crlf
        mov edx, OFFSET studOption1
        call WriteString
        call Crlf
        mov edx, OFFSET studOption2
        call WriteString
        call Crlf
        mov edx, OFFSET studOption3
        call WriteString
        call Crlf
        mov edx, OFFSET studOption4
        call WriteString
        call Crlf
        mov edx, OFFSET choicePrompt
        call WriteString
        mov eax, 07h
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
        jmp InvalidStudentChoice

    IssueBook:
        call IssueNewBook
        jmp StudentMenuLoop

    ReturnBook:
        call ReturnIssuedBook
        jmp StudentMenuLoop

    ViewIssuedBooks:
        call DisplayIssuedBooks
        jmp StudentMenuLoop

    InvalidStudentChoice:
        mov edx, OFFSET invalidChoiceMsg
        call WriteString
        call Crlf
        jmp StudentMenuLoop

    ReturnToMain:
        ret
StudentMenu ENDP

AddNewBook PROC
    mov eax, BookCount
    cmp eax, MAX_BOOKS
    jge NoSpaceForBook

    mov edx, OFFSET bookTitlePrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    mov esi, BookCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET BookTitles
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    mov edx, OFFSET bookAuthorPrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    mov esi, BookCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET BookAuthors
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov esi, BookCount
    mov [BookISBNs + esi * 4], eax

    mov edx, OFFSET bookQuantityPrompt
    call WriteString
    call ReadInt
    mov esi, BookCount
    mov [BookQuantities + esi * 4], eax

    mov esi, BookCount
    mov [BookIssuedTo + esi * 4], 0

    inc BookCount

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
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        mov edx, OFFSET bookQuantityPrompt
        call WriteString
        call ReadInt
        mov [BookQuantities + esi * 4], eax

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
        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookTitles
        add edx, eax
        call WriteString
        call Crlf

        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookAuthors
        add edx, eax
        call WriteString
        call Crlf

        mov eax, [BookISBNs + esi * 4]
        call WriteInt
        call Crlf

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
    mov eax, StudentCount
    cmp eax, MAX_STUDENTS
    jl canRegister

    mov edx, OFFSET maxStudentsMsg
    call WriteString
    call Crlf
    ret

canRegister:
    mov edx, OFFSET studentIDPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

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
    mov esi, StudentCount
    mov eax, tempID
    mov [StudentIDs + esi * 4], eax

    mov edx, OFFSET studentNamePrompt
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    call ReadString

    mov esi, StudentCount
    mov eax, esi
    imul eax, MAX_NAME_LENGTH
    mov edi, OFFSET StudentNames
    add edi, eax
    mov esi, OFFSET tempBuffer
    mov ecx, MAX_NAME_LENGTH
    cld
    rep movsb

    mov esi, StudentCount
    mov [StudentBooksIssued + esi * 4], 0

    inc StudentCount

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

StudentLogin PROC
    mov edx, OFFSET studentIDPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    mov eax, StudentCount
    cmp eax, 0
    je NoStudentsRegistered

    mov ecx, StudentCount
    mov esi, 0
    SearchLoop:
        mov eax, [StudentIDs + esi * 4]
        cmp eax, tempID
        je StudentFound
        inc esi
        loop SearchLoop

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
StudentLogin ENDP

IssueNewBook PROC
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        mov eax, [BookQuantities + esi * 4]
        cmp eax, 0
        jle NoCopiesAvailable

        mov eax, [BookIssuedTo + esi * 4]
        cmp eax, 0
        jne BookAlreadyIssued

        mov eax, tempID
        mov [BookIssuedTo + esi * 4], eax
        dec [BookQuantities + esi * 4]

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
    mov edx, OFFSET bookISBNPrompt
    call WriteString
    call ReadInt
    mov tempID, eax

    mov ecx, BookCount
    mov esi, 0
    SearchLoop:
        mov eax, [BookISBNs + esi * 4]
        cmp eax, tempID
        je BookFound
        inc esi
        loop SearchLoop

    mov edx, OFFSET bookNotFoundMsg
    call WriteString
    call Crlf
    ret

    BookFound:
        mov eax, [BookIssuedTo + esi * 4]
        cmp eax, 0
        je BookNotIssued

        mov [BookIssuedTo + esi * 4], 0
        inc [BookQuantities + esi * 4]

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

        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookTitles
        add edx, eax
        call WriteString
        call Crlf

        mov eax, esi
        imul eax, MAX_NAME_LENGTH
        mov edx, OFFSET BookAuthors
        add edx, eax
        call WriteString
        call Crlf

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
