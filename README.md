# 📚 Library Database Management System

A MySQL-based relational database designed to manage the operations of a library. This system covers entities such as books, publishers, authors, library branches, borrowers, book loans, and book inventory. It includes a sample stored procedure to query the number of copies of a specific book at a given library branch.

---

## 🗃️ Overview

This project demonstrates the design and setup of a normalized library database with proper use of foreign keys, stored procedures, and sample data. It can be used for academic purposes, projects, or as a base for more advanced library management systems.

---

## 📐 Entity-Relationship Model

**Main Entities:**
- **Publisher**
- **Book**
- **Author**
- **Library Branch**
- **Borrower**
- **Book Copies**
- **Book Loans**

---

## 🧱 Database Schema

### 1. `tbl_publisher`
Stores publisher details.

| Column            | Type           | Constraint     |
|-------------------|----------------|----------------|
| PublisherName     | VARCHAR(100)   | Primary Key    |
| PublisherAddress  | VARCHAR(200)   | NOT NULL       |
| PublisherPhone    | VARCHAR(50)    | NOT NULL       |

---

### 2. `tbl_book`
Stores book information and its publisher.

| Column        | Type          | Constraint                         |
|---------------|---------------|------------------------------------|
| BookID        | INT           | Primary Key, AUTO_INCREMENT        |
| Title         | VARCHAR(100)  | NOT NULL                           |
| PublisherName | VARCHAR(100)  | Foreign Key → tbl_publisher        |

---

### 3. `tbl_library_branch`
Stores library branch details.

| Column         | Type          | Constraint      |
|----------------|---------------|-----------------|
| BranchID       | INT           | Primary Key     |
| BranchName     | VARCHAR(100)  | NOT NULL        |
| BranchAddress  | VARCHAR(200)  | NOT NULL        |

---

### 4. `tbl_borrower`
Stores library users/borrowers.

| Column          | Type          | Constraint     |
|------------------|---------------|----------------|
| CardNo           | INT           | Primary Key, AUTO_INCREMENT |
| BorrowerName     | VARCHAR(100)  | NOT NULL       |
| BorrowerAddress  | VARCHAR(200)  | NOT NULL       |
| BorrowerPhone    | VARCHAR(50)   | NOT NULL       |

---

### 5. `tbl_book_copies`
Tracks the number of copies of each book at each branch.

| Column    | Type | Constraint |
|-----------|------|------------|
| CopyID    | INT  | Primary Key, AUTO_INCREMENT |
| BookID    | INT  | Foreign Key → tbl_book      |
| BranchID  | INT  | Foreign Key → tbl_library_branch |
| NoOfCopies| INT  | NOT NULL     |

---

### 6. `tbl_book_authors`
Stores book author information.

| Column     | Type          | Constraint |
|------------|---------------|------------|
| AuthorID   | INT           | Primary Key, AUTO_INCREMENT |
| BookID     | INT           | Foreign Key → tbl_book |
| AuthorName | VARCHAR(100)  | NOT NULL    |

---

### 7. `tbl_book_loans`
Tracks borrowed books and their loan status.

| Column   | Type  | Constraint |
|----------|-------|------------|
| LoanID   | INT   | Primary Key, AUTO_INCREMENT |
| BookID   | INT   | Foreign Key → tbl_book      |
| BranchID | INT   | Foreign Key → tbl_library_branch |
| CardNo   | INT   | Foreign Key → tbl_borrower  |
| DateOut  | DATE  | NULLABLE     |
| DueDate  | DATE  | NULLABLE     |

---

## 🧪 Sample Data

```sql
INSERT INTO tbl_publisher VALUES
('Picador USA', '175 Fifth Avenue, New York, NY 10010', '646-307-5745');

INSERT INTO tbl_book (Title, PublisherName) VALUES
('The Lost Tribe', 'Picador US
