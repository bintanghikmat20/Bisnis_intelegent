CREATE TABLE nelayan(
    id_nelayan INT(11) PRIMARY KEY,
    nama_nelayan VARCHAR(100),
    alamat VARCHAR(255)
);


CREATE TABLE daerah_tangkap(
    id_daerah INT(11) PRIMARY KEY,
    nama_daerah VARCHAR(100),
    koordinat VARCHAR(50)
);


CREATE TABLE jenis_ikan(
    id_jenis_ikan INT(11) PRIMARY KEY,
    nama_ikan VARCHAR(100),
    kategori_ikan VARCHAR(50)
);


CREATE TABLE pelabuhan(
    id_pelabuhan INT(11) PRIMARY KEY,
    nama_pelabuhan VARCHAR(100),
    lokasi VARCHAR(255)
);


CREATE TABLE kapal(
    id_kapal INT PRIMARY KEY,
    nama_kapal VARCHAR(100),
    kapasitas_kapal DECIMAL(10,2),
    id_nelayan INT(11),

    Foreign Key (id_nelayan) REFERENCES nelayan(id_nelayan)
);

CREATE TABLE harga_ikan(
    id_harga INT(11) PRIMARY KEY,
    id_jenis_ikan INT(11),
    id_pelabuhan INT(11),
    harga_per_kg DECIMAL(10,2),

    Foreign Key (id_jenis_ikan) REFERENCES jenis_ikan(id_jenis_ikan),
    Foreign Key (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan)
);


CREATE TABLE penjual_ikan(
    id_penjual INT(11) PRIMARY KEY,
    nama_penjual VARCHAR(100),
    id_pelabuhan INT(11),

    Foreign Key (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan)
);

CREATE TABLE pembeli_ikan(
    id_pembeli INT(11) PRIMARY KEY,
    nama_pembeli VARCHAR(100),
    id_penjual INT(11),
    jumlah_pembelian_kg DECIMAL(10,2),
    tanggal_pembelian DATE,

    Foreign Key (id_penjual) REFERENCES penjual_ikan(id_penjual)
);

CREATE TABLE hasil_tangkapan(
    id_tangkapan INT(11) PRIMARY KEY,
    id_nelayan INT(11),
    id_jenis_ikan INT(11),
    id_daerah INT(11),
    berat_tangkapan_kg DECIMAL(10,2),

    Foreign Key (id_nelayan) REFERENCES nelayan(id_nelayan),
    Foreign Key (id_jenis_ikan) REFERENCES jenis_ikan(id_jenis_ikan),
    Foreign Key (id_daerah) REFERENCES daerah_tangkap(id_daerah)
);

CREATE TABLE pendaratan_ikan(
    id_pendaratan INT(11) PRIMARY KEY,
    id_pelabuhan INT(11),
    id_tangkapan INT(11),
    tanggal_pendaratan DATE,

    Foreign Key (id_pelabuhan) REFERENCES pelabuhan(id_pelabuhan),
    Foreign Key (id_tangkapan) REFERENCES hasil_tangkapan(id_tangkapan)
);


SHOW TABLES;


# list tables;
# pembeli_ikan, kapal, penjual_ikan, nelayan, pelabuhan, daerah_tangkap, hasil_tangkapan, jenis_ikan, harga_ikan, pendaratan_ikan

-- INSERT DATA INTO ALL TABLES --


INSERT INTO nelayan (id_nelayan, nama_nelayan, alamat) VALUES
(1, 'Budi', 'Jalan Laut 10'),
(2, 'Slamet', 'Jalan Samudra 20'),
(3, 'Joko', 'Jalan Bahari 5'),
(4, 'Hasan', 'Jalan Pelabuhan 15'),
(5, 'Hendra', 'Jalan Karang 30'),
(6, 'Rahmat', 'Jalan Laut Selatan 12'),
(7, 'Dewi', 'Jalan Samudra Kecil 18'),
(8, 'Fajar', 'Jalan Ikan Patin 9'),
(9, 'Rizal', 'Jalan Pantai Timur 27'),
(10, 'Andi', 'Jalan Karang Laut 5');


INSERT INTO kapal (id_kapal, nama_kapal, kapasitas_kapal, id_nelayan) VALUES
(101, 'Sumber Laut', 100, 1),
(102, 'Makmur Jaya', 120, 2),
(103, 'Bahari Indah', 150, 3),
(104, 'Laut Sejahtera', 200, 4),
(105, 'Nusantara Indah', 180, 5),
(106, 'Nusantara', 130, 6),
(107, 'Samudra Perkasa', 150, 7),
(108, 'Angin Laut', 110, 8),
(109, 'Bintang Laut', 140, 9),
(110, 'Bahari Sejahtera', 120, 10);


INSERT INTO jenis_ikan (id_jenis_ikan, nama_ikan, kategori_ikan) VALUES
(1, 'Tongkol', 'Pelagis Kecil'),
(2, 'Tenggiri', 'Pelagis Besar'),
(3, 'Cakalang', 'Pelagis Kecil'),
(4, 'Layur', 'Demersal'),
(5, 'Kakap Merah', 'Karang'),
(6, 'Tuna', 'Pelagis Besar'),
(7, 'Barakuda', 'Pelagis Besar'),
(8, 'Ikan Kembung', 'Pelagis Kecil'),
(9, 'Layang', 'Pelagis Kecil'),
(10, 'Kakap', 'Karang');


INSERT INTO daerah_tangkap (id_daerah, nama_daerah, koordinat) VALUES
(301, 'Laut Jawa', '-6.112, 110.419'),
(302, 'Samudra Hindia', '-9.412, 112.873'),
(303, 'Selat Makassar', '-2.205, 117.461'),
(304, 'Laut Banda', '-4.523, 129.289'),
(305, 'Selat Karimata', '-1.832, 108.972'),
(306, 'Laut Sulawesi', '-3.945, 123.721'),
(307, 'Selat Sunda', '-5.882, 105.842'),
(308, 'Laut Jawa', '-6.105, 110.719'),
(309, 'Laut Maluku', '-1.654, 126.451'),
(310, 'Samudra Hindia', '-9.125, 112.453');


INSERT INTO hasil_tangkapan (id_tangkapan, id_nelayan, id_jenis_ikan, id_daerah, berat_tangkapan_kg) VALUES
(5001, 1, 1, 301, 500),
(5002, 2, 2, 302, 400),
(5003, 3, 3, 303, 350),
(5004, 4, 4, 304, 450),
(5005, 5, 5, 305, 600),
(5006, 6, 6, 306, 520),
(5007, 7, 7, 307, 480),
(5008, 8, 8, 308, 360),
(5009, 9, 9, 309, 420),
(5010, 10, 10, 310, 530),
(5011, 1, 1, 301, 200),
(5012, 2, 2, 302, 150),
(5013, 3, 3, 303, 300),
(5014, 4, 4, 304, 250),
(5015, 5, 5, 305, 220),
(5016, 6, 6, 306, 180),
(5017, 2, 2, 302, 160),
(5018, 4, 4, 304, 210),
(5019, 6, 6, 306, 190),
(5020, 7, 7, 307, 230),
(5021, 8, 8, 308, 400);


INSERT INTO pelabuhan (id_pelabuhan, nama_pelabuhan, lokasi) VALUES
(1, 'Pelabuhan Perikanan Samudra Jakarta', 'Jakarta'),
(2, 'Pelabuhan Perikanan Samudra Cilacap', 'Cilacap'),
(3, 'Pelabuhan Perikanan Samudra Bitung', 'Bitung'),
(4, 'Pelabuhan Perikanan Samudra Kendari', 'Kendari'),
(5, 'Pelabuhan Perikanan Samudra Ambon', 'Ambon'),
(6, 'Pelabuhan Perikanan Samudra Tual', 'Tual'),
(7, 'Pelabuhan Perikanan Samudra Palabuhanratu', 'Palabuhanratu'),
(8, 'Pelabuhan Perikanan Samudra Muara Angke', 'Jakarta Utara'),
(9, 'Pelabuhan Perikanan Samudra Ternate', 'Ternate'),
(10, 'Pelabuhan Perikanan Samudra Bali', 'Bali');


INSERT INTO pendaratan_ikan (id_pendaratan, id_pelabuhan, id_tangkapan, tanggal_pendaratan) VALUES
(9001, 1, 5001, '2024-09-12'),
(9002, 2, 5002, '2024-09-13'),
(9003, 3, 5003, '2024-09-14'),
(9004, 4, 5004, '2024-09-15'),
(9005, 5, 5005, '2024-09-16'),
(9006, 6, 5006, '2024-09-16'),
(9007, 7, 5007, '2024-09-17'),
(9008, 8, 5008, '2024-09-17'),
(9009, 9, 5009, '2024-09-18'),
(9010, 10, 5010, '2024-09-18'),
(9011, 1, 5011, '2024-09-19'),
(9012, 2, 5012, '2024-09-19'),
(9013, 3, 5013, '2024-09-20'),
(9014, 4, 5014, '2024-09-20'),
(9015, 5, 5015, '2024-09-21'),
(9016, 6, 5016, '2024-09-25'),
(9017, 2, 5017, '2024-09-26'),
(9018, 4, 5018, '2024-09-27'),
(9019, 6, 5019, '2024-09-28'),
(9020, 7, 5020, '2024-09-29'),
(9021, 10, 5021, '2024-09-30');


INSERT INTO penjual_ikan (id_penjual, nama_penjual, id_pelabuhan) VALUES
(101, 'Pak Budi', 1),
(102, 'Pak Slamet', 2),
(103, 'Pak Joko', 3),
(104, 'Bu Siti', 4),
(105, 'Pak Yoyo', 5),
(106, 'Pak Herman', 6),
(107, 'Bu Nina', 7),
(108, 'Pak Edi', 8),
(109, 'Bu Wati', 9),
(110, 'Pak Suryo', 10);


INSERT INTO harga_ikan (id_harga, id_jenis_ikan, id_pelabuhan, harga_per_kg) VALUES
(1, 1, 1, 50000),
(2, 2, 2, 75000),
(3, 3, 3, 60000),
(4, 4, 4, 40000),
(5, 5, 5, 85000),
(6, 6, 6, 85000),
(7, 7, 7, 76000),
(8, 8, 8, 35000),
(9, 9, 9, 32000),
(10, 10, 10, 70000);


INSERT INTO pembeli_ikan (id_pembeli, nama_pembeli, id_penjual, jumlah_pembelian_kg, tanggal_pembelian) VALUES
(1001, 'Pak Ahmad', 101, 50, '2024-09-12'),
(1002, 'Bu Rini', 102, 100, '2024-09-13'),
(1003, 'Pak Sugeng', 103, 75, '2024-09-14'),
(1004, 'Bu Dian', 104, 60, '2024-09-15'),
(1005, 'Pak Iwan', 106, 90, '2024-09-16'),
(1006, 'Bu Ani', 107, 40, '2024-09-16'),
(1007, 'Pak Hari', 108, 120, '2024-09-17'),
(1008, 'Bu Nita', 109, 85, '2024-09-17'),
(1009, 'Pak Danu', 110, 70, '2024-09-18'),
(1010, 'Bu Sari', 101, 95, '2024-09-18'),
(1011, 'Pak Ahmad', 101, 50, '2024-09-19'),
(1012, 'Pak Budi', 102, 75, '2024-09-19'),
(1013, 'Bu Citra', 103, 60, '2024-09-20'),
(1014, 'Bu Dewi', 104, 80, '2024-09-20'),
(1015, 'Pak Eko', 106, 70, '2024-09-21'),
(1016, 'Pak Fahmi', 101, 55, '2024-09-25'),
(1017, 'Bu Gita', 103, 62, '2024-09-26'),
(1018, 'Pak Hendra', 104, 78, '2024-09-27'),
(1019, 'Bu Indah', 102, 8, '2024-09-28'),
(1020, 'Pak Joko', 106, 710, '2024-09-29');



SELECT * FROM nelayan;
SELECT * FROM daerah_tangkap;
SELECT * FROM jenis_ikan;
SELECT * FROM pelabuhan;    
SELECT * FROM kapal;
SELECT * FROM harga_ikan;
SELECT * FROM penjual_ikan;
SELECT * FROM pembeli_ikan;
SELECT * FROM hasil_tangkapan;
SELECT * FROM pendaratan_ikan;



UPDATE hasil_tangkapan 
SET berat_tangkapan_kg = 550
WHERE id_tangkapan = 5001;

UPDATE harga_ikan
SET harga_per_kg = 80000
WHERE id_jenis_ikan = 2 AND id_pelabuhan = 2;

UPDATE penjual_ikan
SET nama_penjual = 'pak joni'
where nama_penjual = 'pak joko';

UPDATE pelabuhan
SET lokasi ='Ambon baru'
WHERE lokasi = 'Ambon';

UPDATE pendaratan_ikan
SET tanggal_pendaratan = '2024-09-15'
WHERE id_pendaratan = 9003;


DELETE FROM pendaratan_ikan 
WHERE tanggal_pendaratan < '2024-09-30';

DELETE FROM pendaratan_ikan
WHERE id_tangkapan = 5021;
DELETE FROM hasil_tangkapan 
WHERE id_tangkapan = 5021;

DELETE FROM penjual_ikan
WHERE id_penjual NOT IN(
    SELECT DISTINCT id_penjual FROM pembeli_ikan
);

SELECT * FROM penjual_ikan;


SELECT kapal.nama_kapal, kapal.kapasitas_kapal FROM kapal
WHERE kapal.kapasitas_kapal > 150;

SELECT * FROM jenis_ikan
WHERE kategori_ikan = 'Pelagis Kecil';

SELECT hasil_tangkapan.id_nelayan, nelayan.nama_nelayan, SUM(hasil_tangkapan.berat_tangkapan_kg) AS total_berat_kg
FROM nelayan
JOIN hasil_tangkapan ON nelayan.id_nelayan = hasil_tangkapan.id_nelayan
GROUP BY hasil_tangkapan.id_nelayan, nelayan.nama_nelayan;


select pembeli_ikan.nama_pembeli, pembeli_ikan.jumlah_pembelian_kg
FROM pembeli_ikan
WHERE pembeli_ikan.jumlah_pembelian_kg > 100;


SELECT jenis_ikan.nama_ikan, harga_ikan.harga_per_kg
FROM jenis_ikan
JOIN harga_ikan ON jenis_ikan.id_jenis_ikan = harga_ikan.id_jenis_ikan
WHERE harga_ikan.harga_per_kg > 60000;


SELECT * FROM pembeli_ikan
WHERE tanggal_pembelian = '2024-09-20';

SELECT hasil_tangkapan.id_tangkapan, jenis_ikan.nama_ikan, hasil_tangkapan.berat_tangkapan_kg
FROM hasil_tangkapan
JOIN jenis_ikan ON hasil_tangkapan.id_jenis_ikan = jenis_ikan.id_jenis_ikan
ORDER BY hasil_tangkapan.id_tangkapan ASC;

SELECT daerah_tangkap.nama_daerah, SUM(hasil_tangkapan.berat_tangkapan_kg) AS total_berat_kg
FROM daerah_tangkap
JOIN hasil_tangkapan ON daerah_tangkap.id_daerah = hasil_tangkapan.id_daerah
GROUP BY daerah_tangkap.nama_daerah;


SELECT harga_ikan.harga_per_kg, jenis_ikan.nama_ikan, ROUND(AVG(harga_ikan.harga_per_kg),2) AS rata_rata_harga
FROM harga_ikan
JOIN jenis_ikan ON harga_ikan.id_jenis_ikan = jenis_ikan.id_jenis_ikan
GROUP BY jenis_ikan.nama_ikan


SELECT hasil_tangkapan.id_nelayan, nelayan.nama_nelayan, SUM(hasil_tangkapan.berat_tangkapan_kg) AS total_berat_kg
FROM nelayan
JOIN hasil_tangkapan ON nelayan.id_nelayan = hasil_tangkapan.id_nelayan
GROUP BY hasil_tangkapan.id_nelayan, nelayan.nama_nelayan


SELECT penjual_ikan.id_penjual, penjual_ikan.nama_penjual, COUNT(DISTINCT pembeli_ikan.id_pembeli) AS jumlah_pembeli
FROM penjual_ikan
LEFT JOIN pembeli_ikan ON penjual_ikan.id_penjual = pembeli_ikan.id_penjual
GROUP BY penjual_ikan.id_penjual, penjual_ikan.nama_penjual


SELECT jenis_ikan.nama_ikan, SUM(hasil_tangkapan.berat_tangkapan_kg) AS total_berat_kg
FROM jenis_ikan
JOIN hasil_tangkapan ON jenis_ikan.id_jenis_ikan = hasil_tangkapan.id_jenis_ikan
GROUP BY jenis_ikan.nama_ikan
ORDER BY total_berat_kg DESC
LIMIT 1;

SELECT nelayan.id_nelayan, nelayan.nama_nelayan, jenis_ikan.id_jenis_ikan,
jenis_ikan.nama_ikan,(
    SELECT SUM(hasil_tangkapan.berat_tangkapan_kg)
    FROM hasil_tangkapan
    WHERE hasil_tangkapan.id_nelayan = nelayan.id_nelayan
    AND hasil_tangkapan.id_jenis_ikan = jenis_ikan.id_jenis_ikan
) AS total_berat
FROM nelayan
JOIN hasil_tangkapan ON nelayan.id_nelayan = hasil_tangkapan.id_nelayan
JOIN jenis_ikan ON hasil_tangkapan.id_jenis_ikan = jenis_ikan.id_jenis_ikan
GROUP BY nelayan.id_nelayan, jenis_ikan.id_jenis_ikan, nelayan.nama_nelayan, jenis_ikan.nama_ikan
ORDER BY nelayan.nama_nelayan ASC, jenis_ikan.nama_ikan ASC;




SELECT pelabuhan.id_pelabuhan, pelabuhan.nama_pelabuhan, (
    SELECT AVG(harga_ikan.harga_per_kg)
    FROM harga_ikan
    WHERE harga_ikan.id_pelabuhan = pelabuhan.id_pelabuhan
) AS rata_rata_harga
FROM pelabuhan
ORDER BY nama_pelabuhan ASC;



SELECT 
    p.id_pembeli,
    p.nama_pembeli,
    (p.jumlah_pembelian_kg * (
        SELECT h.harga_per_kg 
        FROM harga_ikan h 
        JOIN penjual_ikan pj ON h.id_pelabuhan = pj.id_pelabuhan 
        WHERE pj.id_penjual = p.id_penjual 
        LIMIT 1
    )) AS total_pembelian
FROM pembeli_ikan p
HAVING total_pembelian > 5000
ORDER BY total_pembelian DESC;