CREATE database library;
USE library;

CREATE TABLE tbl_publisher (
    PublisherName VARCHAR(100) PRIMARY KEY,
    PublisherAddress VARCHAR(200) NOT NULL,
    PublisherPhone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    PublisherName VARCHAR(100),
    FOREIGN KEY (PublisherName) REFERENCES tbl_publisher(PublisherName)
);

CREATE TABLE tbl_library_branch (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    BranchAddress VARCHAR(200) NOT NULL
);

CREATE TABLE tbl_borrower (
    CardNo INT AUTO_INCREMENT PRIMARY KEY,
    BorrowerName VARCHAR(100) NOT NULL,
    BorrowerAddress VARCHAR(200) NOT NULL,
    BorrowerPhone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_book_copies (
    CopyID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BranchID INT,
    NoOfCopies INT NOT NULL,
    FOREIGN KEY (BookID) REFERENCES tbl_book(BookID),
    FOREIGN KEY (BranchID) REFERENCES tbl_library_branch(BranchID)
);

CREATE TABLE tbl_book_authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    AuthorName VARCHAR(100) NOT NULL,
    FOREIGN KEY (BookID) REFERENCES tbl_book(BookID)
);

CREATE TABLE tbl_book_loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BranchID INT,
    CardNo INT,
    DateOut DATE,
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES tbl_book(BookID),
    FOREIGN KEY (BranchID) REFERENCES tbl_library_branch(BranchID),
    FOREIGN KEY (CardNo) REFERENCES tbl_borrower(CardNo)
);

INSERT INTO tbl_publisher VALUES
('Picador USA', '175 Fifth Avenue, New York, NY 10010', '646-307-5745');

INSERT INTO tbl_book (Title, PublisherName) VALUES
('The Lost Tribe', 'Picador USA');

INSERT INTO tbl_library_branch (BranchName, BranchAddress) VALUES
('Sharpstown', '32 Corner Road, New York, NY 10012');

INSERT INTO tbl_book_copies (BookID, BranchID, NoOfCopies) VALUES
(1, 1, 5);

DELIMITER $$

CREATE PROCEDURE GetBookCopiesAtBranch(
    IN bookTitle VARCHAR(100),
    IN branchName VARCHAR(100)
)
BEGIN
    SELECT 
        b.Title AS BookTitle,
        lb.BranchName,
        bc.NoOfCopies
    FROM tbl_book_copies bc
    JOIN tbl_book b ON bc.BookID = b.BookID
    JOIN tbl_library_branch lb ON bc.BranchID = lb.BranchID
    WHERE b.Title = bookTitle AND lb.BranchName = branchName;
END$$

DELIMITER ;

CALL GetBookCopiesAtBranch('The Lost Tribe', 'Sharpstown');
