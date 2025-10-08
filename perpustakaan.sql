
# NO 1
CREATE TABLE anggota (
    id_anggota INT(3) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nm_anggota VARCHAR(30),
    alamat TEXT,
    ttl_anggota TEXT,
    status_anggota VARCHAR(1)
);



CREATE TABLE buku (
    kd_buku INT(5) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    judul_buku VARCHAR(50),
    pengarang VARCHAR(30),
    penerbit VARCHAR(30),
    jenis_buku VARCHAR(20)
);


SELECT * FROM buku;

CREATE TABLE pinjam (
    id_pinjam INT(5) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tgl_pinjam DATE,
    jumlah_pinjam INT(2),
    tgl_kembali DATE,
    id_anggota INT(3),
    kd_buku INT(5),

    CONSTRAINT fk_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
    CONSTRAINT fk_buku FOREIGN KEY (kd_buku) REFERENCES buku(kd_buku)
);
DROP TABLE pinjam;


SELECT*FROM pinjam


INSERT INTO anggota (id_anggota, nm_anggota, alamat, ttl_anggota, status_anggota)
VALUES
(1, 'dadang', 'bandung', 'bandung, 17 mei 2004', 'aktif'),
(2, 'dina', 'jakarta', 'jakarta, 20 juni 2004', 'aktif'),
(3, 'dodi', 'surabaya', 'surabaya, 15 agustus 2004', 'aktif'),
(4, 'dina', 'medan', 'medan, 10 oktober 2004', 'aktif'),
(5, 'dina sari', 'semarang', 'semarang, 25 desember 2004', 'aktif');

INSERT INTO anggota (id_anggota, nm_anggota, alamat, ttl_anggota, status_anggota)
VALUES
(6, 'fauzi', 'sukabumi', 'bandung, 19 mei 2004', 'aktif');

UPDATE anggota
SET nm_anggota = 'dadang'WHERE id_anggota IN (1);

INSERT INTO buku (kd_buku, judul_buku, pengarang, penerbit, jenis_buku)
VALUES
(123, 'laskar pelangi', 'andre', 'mizan', 'novel'),
(124, 'bumi manusia', 'pramudya ananta toer', 'kpg', 'novel'),
(125, 'negara kertas', 'sopi', 'gramedia', 'sejarah'),
(126, 'london', 'dzaki', 'mizan', 'traveling'),
(127, 'bandung', 'attar', 'kpg', 'traveling');



INSERT INTO pinjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku)
VALUES
(1, '2023-05-01', 1, '2023-05-08', 1, 123),
(2, '2023-05-02', 2, '2023-05-09', 2, 124),
(5, '2023-05-05', 3, '2023-05-12', 5, 127);

INSERT INTO pinjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku)
VALUES
(7, '2025-10-08', 6, '2025-10-15', 2, 126);

#No 2


#menampilkan data anggota yang pernah meminjam buku
SELECT anggota.id_anggota, anggota.nm_anggota, anggota.alamat, anggota.ttl_anggota, pinjam.jumlah_pinjam
FROM anggota
JOIN pinjam ON anggota.id_anggota = pinjam.id_anggota;

# Menampilkan anggota yang belum meminjam buku
SELECT anggota.id_anggota, anggota.nm_anggota, anggota.alamat, anggota.ttl_anggota, pinjam.id_pinjam
FROM anggota
LEFT JOIN pinjam ON anggota.id_anggota = pinjam.id_anggota
WHERE pinjam.id_anggota IS NULL;


SELECT * FROM pinjam
WHERE tgl_pinjam = '2025-10-08';


SELECT * FROM pinjam
WHERE jumlah_pinjam >3;



SELECT * FROM pinjam;

SELECT buku.kd_buku, buku.judul_buku, buku.pengarang, buku.penerbit, buku.jenis_buku, 
    pinjam.tgl_pinjam, pinjam.tgl_kembali, anggota.nm_anggota
FROM buku
JOIN pinjam ON buku.kd_buku = pinjam.kd_buku
JOIN anggota ON pinjam.id_anggota = anggota.id_anggota
WHERE pinjam.tgl_kembali < CURDATE();

UPDATE anggota
SET status_anggota = 'tidak aktif'
WHERE id_anggota NOT IN (
    SELECT DISTINCT id_anggota 
    FROM pinjam
);
