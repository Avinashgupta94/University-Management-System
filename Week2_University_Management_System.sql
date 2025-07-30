    CREATE DATABASE UniversityDB;
    GO

    USE UniversityDB;
    GO

    CREATE TABLE Students(
        StudentID INT PRIMARY KEY IDENTITY(1,1),
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE
    );
    GO

    CREATE TABLE Courses(
        CourseID INT PRIMARY KEY IDENTITY(1,1),
        CourseName NVARCHAR(100) NOT NULL,
        Credits INT NOT NULL CHECK (Credits > 0)
    );
    GO

    CREATE TABLE Enrollments(
        EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
        StudentID INT,
        CourseID INT,
        EnrollmentDate Date NOT NULL,
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
    );
    GO


    -- Insert Students
    INSERT INTO Students (FirstName, LastName, Email)
    VALUES
    ('ALice', 'Johnson', 'alice.jhonson@example.com'),
    ('Bob', 'Smith', 'bob.smith@example.com'),
    ('Charlie', 'Brown', 'charlie.brown@exapmle.com');
    GO

    -- Insert Courses
    INSERT INTO Courses (CourseName, Credits)
    VALUES
    ('Database Systems', 3),
    ('Database Structures', 4),
    ('Web Development', 3);
    GO

    -- Insert Enrollments
    INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
    VALUES
    -- Alice enrolled in Database Systems
    (1, 1, '2024-09-01'),
    -- Alice enrolled in Data Structures
    (1, 2, '2024-09-02'),
    -- Bob enrolled in Database Systems
    (2, 1, '2024-09-01'),
    -- Charlie enrolled in Web Development
    (3, 3, '2024-09-03');
    GO

    SELECT * FROM Students;

    SELECT * FROM Courses;

    SELECT * FROM Enrollments;


    SELECT CourseName, COUNT(*) AS Total
    FROM Courses
    GROUP BY CourseName
    HAVING COUNT(*) > 1;


    DELETE FROM Courses
    WHERE CourseID NOT IN (
    SELECT MIN(CourseID)
    FROM Courses
    GROUP BY CourseName
    );

    SELECT * FROM Courses;

    SELECT E.EnrollmentID, S.FirstName, S.LastName, C.CourseName, E.EnrollmentDate
    FROM Enrollments E
    JOIN Students S ON E.StudentID = S.StudentID
    JOIN Courses C ON E.CourseID = C.CourseID;
