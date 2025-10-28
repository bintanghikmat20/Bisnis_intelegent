-- Departemen / Prodi
CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100)
);
-- Mahasiswa
CREATE TABLE students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
entry_year INT,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- Dosen
CREATE TABLE lecturers (
lect_id INT PRIMARY KEY,
lect_name VARCHAR(100),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- Mata kuliah
CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_code VARCHAR(20) UNIQUE,
course_title VARCHAR(150),
credits INT,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- Kelas (penyelenggaraan MK per semester & dosen)
CREATE TABLE classes (
class_id INT PRIMARY KEY,
course_id INT,
lect_id INT,
semester VARCHAR(10), -- misal: '2025-1'
FOREIGN KEY (course_id) REFERENCES courses(course_id),
FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id)
);
-- Ruang
CREATE TABLE rooms (
room_id INT PRIMARY KEY,
room_name VARCHAR(50),
capacity INT
);
-- Jadwal kelas di ruang
CREATE TABLE schedules (
schedule_id INT PRIMARY KEY,
class_id INT,
room_id INT,
day_of_week VARCHAR(10), -- Mon..Sun (silakan sesuaikan)
start_time TIME,
end_time TIME,
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);
-- KRS (relasi many-to-many mhs <-> kelas)
CREATE TABLE enrollments (
student_id INT,
class_id INT,
grade VARCHAR(2), -- contoh: 'A','B','C', NULL bila belum nilai
PRIMARY KEY (student_id, class_id),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (class_id) REFERENCES classes(class_id)
);
-- Prasyarat MK (self-join pada courses)
CREATE TABLE prerequisites (
course_id INT,
prereq_id INT,
PRIMARY KEY (course_id, prereq_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id),
FOREIGN KEY (prereq_id) REFERENCES courses(course_id)
);
-- Hierarki dosen (self-join lecturers: atasan/pembina)
CREATE TABLE lecturer_supervisions (
lect_id INT,
supervisor_id INT,
PRIMARY KEY (lect_id, supervisor_id),
FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id),
FOREIGN KEY (supervisor_id) REFERENCES lecturers(lect_id)
);

INSERT INTO departments VALUES
(10,'Sistem Informasi Kelautan'),
(20,'Ilmu Komputer'),
(30,'Biologi Kelautan');

INSERT INTO students VALUES
(2103118,'Roni Antonius Sinabutar',2021,10),
(2103120,'Salsa Aurelia',2021,10),
(2204101,'Rakhil Syakira Yusuf',2022,10),
(2205205,'Adit Pratama',2022,20),
(2306102,'Nadia Putri',2023,20),
(2307107,'Bima Mahesa',2023,30);

INSERT INTO lecturers VALUES
(501, 'Willdan',10),
(502,'Supriadi',10),
(503,'Ayang',20),
(504,'Alam',30),
(505,'Luthfi',10);
INSERT INTO courses VALUES
(1001,'KL202','Algoritma & Pemrograman',3,10),
(1002,'KL218','Sistem Basis Data',3,10),
(1003,'CS101','Pengantar Ilmu Komputer',2,20),
(1004,'CS205','Basis Data Lanjut',3,20),
(1005,'MB110','Biologi Laut Dasar',2,30),
(1006,'KL305','SIG Kelautan',3,10);
INSERT INTO classes VALUES
(9001,1002,501,'2025-1'), -- SBD oleh Willdan
(9002,1001,502,'2025-1'), -- Algo oleh Supriadi
(9003,1003,503,'2025-1'), -- Pengantar IK oleh Ayang
(9004,1005,504,'2025-1'), -- Biologi Laut Dasar oleh Alam
(9005,1004,503,'2025-1'), -- Basis Data Lanjut oleh Ayang
(9006,1006,505,'2025-1'); -- SIG Kelautan oleh Luthfi
INSERT INTO rooms VALUES
(1,'Lab Big Data',30),
(2,'Ruang Kuliah 201',40),
(3,'Lab Komputasi 1',25),
(4,'Aula 3',100);
INSERT INTO schedules VALUES
(7001,9001,3,'Monday','08:00','10:30'),
(7002,9002,2,'Tuesday','10:00','12:00'),
(7003,9003,2,'Wednesday','08:00','10:00'),
(7004,9004,4,'Thursday','13:00','15:00'),
(7005,9005,3,'Friday','09:00','11:30'),
(7006,9006,1,'Monday','13:00','15:30');
INSERT INTO enrollments VALUES
(2103118,9001,'A'),
(2103118,9002,'B'),
(2103120,9001,'B'),
(2103120,9006,'A'),
(2204101,9001,NULL),
(2204101,9005,NULL),
(2205205,9003,'A'),
(2306102,9003,'B'),
(2306102,9005,NULL),
(2307107,9004,'A');
INSERT INTO prerequisites VALUES
(1004,1002), -- Basis Data Lanjut mensyaratkan Sistem Basis Data
(1006,1001); -- SIG Kelautan mensyaratkan Algoritma & Pemrograman
INSERT INTO lecturer_supervisions VALUES
(501,505), -- Willdan dibina oleh Luthfi
(502,501), -- Supriadi dibina oleh Willdan
(503,501), -- Ayang dibina oleh Willdan
(504,505); -- Alam dibina oleh Luthfi



SELECT s.student_name, d.dept_name
FROM students s
INNER JOIN departments d ON s.dept_id = d.dept_id;

#Daftar kelas beserta mata kuliah dan dosen pengajarnya.
SELECT c.class_id, l.course_title, le.lect_name
FROM classes c  
INNER JOIN courses l ON c.course_id = l.course_id
INNER JOIN lecturers le ON c.lect_id = le.lect_id;

#Mahasiswa yang mengambil kelas ‘Sistem Basis Data’ (1002).
SELECT s.student_id, s.student_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes c ON e.class_id = c.class_id
JOIN courses co ON c.course_id = co.course_id
WHERE co.course_id = 1002;

#Jadwal lengkap kelas (hari, jam, ruang) untuk tiap mata kuliah.
SELECT c.class_id, co.course_title, sch.day_of_week, sch.start_time, sch.end_time, r.room_name
FROM classes c
INNER JOIN courses co ON c.course_id = co.course_id
INNER JOIN schedules sch ON c.class_id = sch.class_id
INNER JOIN rooms r ON sch.room_id = r.room_id;

SELECT departments.dept_name, COUNT(DISTINCT students.student_id) AS jumlah_mahasiswa
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN departments ON students.dept_id = departments.dept_id
WHERE classes.semester = '2025-1'
GROUP BY departments.dept_name;

-- Nomer 6
SELECT classes.class_id, lecturers.lect_name, courses.course_title
FROM classes
INNER JOIN lecturers ON classes.lect_id = lecturers.lect_id
INNER JOIN courses ON classes.course_id = courses.course_id
WHERE lecturers.dept_id = courses.dept_id;

-- Nomer 7 
SELECT DISTINCT students.student_name, courses.course_title
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
WHERE students.dept_id = 10 AND courses.dept_id <> 10;

-- Nomer 8 
SELECT courses.course_title AS mata_kuliah, prereq.course_title AS prasyarat
FROM prerequisites
INNER JOIN courses ON prerequisites.course_id = courses.course_id
INNER JOIN courses AS prereq ON prerequisites.prereq_id = prereq.course_id;

-- Nomer 9 
SELECT lecturers.lect_name AS dosen, supervisor.lect_name AS pembina
FROM lecturer_supervisions
INNER JOIN lecturers ON lecturer_supervisions.lect_id = lecturers.lect_id
INNER JOIN lecturers AS supervisor ON lecturer_supervisions.supervisor_id = supervisor.lect_id;

-- Nomer 10
SELECT DISTINCT classes.class_id, courses.course_title
FROM enrollments
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
WHERE enrollments.grade IS NULL;

-- Nomer 11
SELECT students.student_name, departments.dept_name
FROM students
INNER JOIN departments ON students.dept_id = departments.dept_id
INNER JOIN courses ON courses.course_id = 1006
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
LEFT JOIN classes ON enrollments.class_id = classes.class_id 
AND classes.course_id = 1006
WHERE students.dept_id = courses.dept_id
AND classes.class_id IS NULL;

-- Nomer 12
SELECT schedules.day_of_week, COUNT(schedules.class_id) AS jumlah_kelas, SUM(rooms.capacity) AS total_kapasitas
FROM schedules
INNER JOIN rooms ON schedules.room_id = rooms.room_id
GROUP BY schedules.day_of_week;

-- Nomer 13
SELECT students.student_name, SUM(courses.credits) AS total_sks
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
GROUP BY students.student_name;

-- Nomer 14
INSERT INTO classes VALUES (9007, 1003, 501, '2025-1');

SELECT classes.class_id, courses.course_title, departments.dept_name AS course_department, lecturers.lect_name, departments2.dept_name AS lecturer_department
FROM classes
INNER JOIN courses ON classes.course_id = courses.course_id
INNER JOIN lecturers ON classes.lect_id = lecturers.lect_id
INNER JOIN departments ON courses.dept_id = departments.dept_id
INNER JOIN departments AS departments2 ON lecturers.dept_id = departments2.dept_id
WHERE courses.dept_id != lecturers.dept_id;

-- Nomer 15
SELECT classes.class_id, courses.course_title, rooms.room_name, rooms.capacity,
COUNT(enrollments.student_id) AS jumlah_peserta,
CASE 
WHEN COUNT(enrollments.student_id) >= rooms.capacity THEN 'PENUH'
ELSE 'TERSEDIA' 
END AS status_kelas
FROM classes
INNER JOIN courses ON classes.course_id = courses.course_id
INNER JOIN schedules ON classes.class_id = schedules.class_id
INNER JOIN rooms ON schedules.room_id = rooms.room_id
LEFT JOIN enrollments ON classes.class_id = enrollments.class_id
GROUP BY classes.class_id, courses.course_title, rooms.room_name, rooms.capacity;


-- Nomer 16
SELECT students.student_name, courses.course_code, courses.course_title, classes.semester
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
WHERE classes.semester = '2025-1'
ORDER BY students.student_name, courses.course_code;


-- Nomer 17
SELECT DISTINCT prereq_courses.course_id,
prereq_courses.course_title
FROM prerequisites
INNER JOIN courses prereq_courses ON prerequisites.prereq_id = prereq_courses.course_id;


-- Nomer 18
SELECT lecturers.lect_name AS dosen_pembina, COUNT(lecturer_supervisions.lect_id) AS jumlah_dibina
FROM lecturer_supervisions
INNER JOIN lecturers ON lecturer_supervisions.supervisor_id = lecturers.lect_id
GROUP BY lecturers.lect_name;

-- Nomer 19
SELECT students.student_name, courses.course_title, rooms.room_name, schedules.day_of_week
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
INNER JOIN schedules ON classes.class_id = schedules.class_id
INNER JOIN rooms ON schedules.room_id = rooms.room_id
WHERE schedules.day_of_week = 'Monday';

-- Nomer 20
SELECT students.student_name, departments.dept_name AS student_department, courses.course_title, departments2.dept_name AS course_department
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN departments ON students.dept_id = departments.dept_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN courses ON classes.course_id = courses.course_id
INNER JOIN departments AS departments2 ON courses.dept_id = departments2.dept_id
WHERE students.dept_id != courses.dept_id;

-- Nomer 21
SELECT lecturers.lect_name, classes.class_id, courses.course_title
FROM lecturers
LEFT JOIN classes ON lecturers.lect_id = classes.lect_id
LEFT JOIN courses ON classes.course_id = courses.course_id;

-- Nomer 22
SELECT courses.course_id, courses.course_title, classes.class_id, classes.semester
FROM courses
LEFT JOIN classes ON courses.course_id = classes.course_id
AND classes.semester = '2025-1';

-- Nomer 23
SELECT courses.course_title AS mata_kuliah, prerequisites_courses.course_title AS prasyarat
FROM courses
LEFT JOIN prerequisites ON courses.course_id = prerequisites.course_id
LEFT JOIN courses AS prerequisites_courses ON prerequisites.prereq_id = prerequisites_courses.course_id;

-- Nomer 24
SELECT students.student_name, lecturers.lect_name AS dosen_pengajar, supervisors.lect_name AS dosen_pembina, courses.course_title
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.student_id
INNER JOIN classes ON enrollments.class_id = classes.class_id
INNER JOIN lecturers ON classes.lect_id = lecturers.lect_id
INNER JOIN lecturer_supervisions ON lecturers.lect_id = lecturer_supervisions.lect_id
INNER JOIN lecturers AS supervisors ON lecturer_supervisions.supervisor_id = supervisors.lect_id
INNER JOIN courses ON classes.course_id = courses.course_id
WHERE lecturers.lect_id = lecturer_supervisions.lect_id;

-- Nomer 25
INSERT INTO schedules VALUES
(7007,9002,3,'Monday','09:30','11:00');

SELECT s1.class_id AS class_id_1, s2.class_id AS class_id_2, s1.day_of_week, rooms.room_name, s1.start_time AS start_1, s1.end_time AS end_1, s2.start_time AS start_2, s2.end_time AS end_2
FROM schedules s1
INNER JOIN schedules s2 
    ON s1.room_id = s2.room_id
    AND s1.day_of_week = s2.day_of_week
    AND s1.class_id < s2.class_id
    AND ((s1.start_time < s2.end_time) AND (s2.start_time < s1.end_time))
INNER JOIN rooms ON s1.room_id = rooms.room_id
ORDER BY s1.day_of_week, rooms.room_name;
