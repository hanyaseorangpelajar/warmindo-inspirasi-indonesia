# Sistem Informasi Point of Sales pada Warmindo Inspirasi Indonesia

<br/>

## Latar Belakang

Warmindo Inspirasi Indonesia adalah sebuah warung yang menjual berbagai jenis makanan dan minuman di kelurahan Tembalang. Target pasar dari warung tersebut adalah mahasiswa/mahasiswi yang sedang berkuliah di beberapa kampus sekitar kelurahan Tembalang. Jam operasional dari warung tersebut adalah selama 12 jam dari pukul 11.00 - 23.00 WIB, yang terbagi menjadi 2 shift. Saat ini, terdapat 10 karyawan yang bekerja di warung tersebut. Warmindo Inspirasi Indonesia menyediakan layanan makan di tempat dan pemesanan untuk dibawa pulang. Terdapat 12 meja dan 8 tempat lesehan di lantai 1 serta 25 meja di lantai 2 bagi pelanggan yang ingin makan ditempat. Pemilik warung merencanakan akan membuka cabang dalam waktu dekat.

<br/>

## Permasalahan

Semakin banyaknya pelanggan yang ingin membeli makanan/minuman di warung tersebut, membuat karyawan merasa kewalahan. Terlebih saat ini masing menggunakan pensil dan kertas yang ditulis dengan tangan sebagai penanda pesanan.
Beberapa pelanggan adalah pelanggan tetap, sehingga pemilik warung merasa perlu memberikan tambahan berubah hadiah tertentu untuk membuat mereka tetap loyal untuk mengunjungi warung tersebut. Namun, cukup sulit mengidentifikasi pelanggan tetap tersebut jika hanya mengandalkan ingatan pemilik warung.
Banyak pelanggan yang baru dating menanyakan ketersediaan meja yang kosong kepada karyawan warung, namun tidak dapat dijawab dengan cepat oleh karyawan tersebut. Karyawan harus berkeliling untuk melihat secara langsung terlebih dahulu untuk memastikan.
Pemilik warung kesulitan untuk mengetahui hasil penjualan harian secara cepat, karena proses rekap hasil penjualan masih dilakukan secara manual oleh karyawan ketika shift kerja berakhir.

<br/>

## Solusi

Pemilik warung meminta kelompok Anda untuk membuatkan sebuah sistem informasi yang dapat mengelola transaksi penjualan di Warmindo Inspirasi Indonesia. Sistem informasi tersebut merupakan sistem informasi berbasis platform mobile.

<br/>

## Spesifikasi Kebutuhan

1. Pengguna aplikasi: Petugas dapur

<br/>

2. Alur proses bisnis: Petugas dapur akan mengatur pembuatan masakan dan menandai pesanan yang telah selesai.
   - Pengkodean meja menggunakan kode A untuk lantai 1 dan B untuk lantai 2. Dimulai dari A1, A2, dst.
   - Pengkodean lokasi warung menggunakan WT1, WT2, dst.
   - Pengkodean transaksi menggunakan format [kode warung] [tahun] [bulan] [tanggal] [shift] [nomor transaksi] seperti contoh: WT1202311270001
   - Pengkodean identitas karyawan menggunakan format [kode warung] [tahun masuk] [bulan masuk] [nomor karyawan bulan tersebut diawali dengan simbol X] seperti contoh: WT1202310X01
   - Setiap karyawan yang akan masuk shift perlu merekam waktu masuk. Begitu pula pada saat keluar juga perlu merekam waktu keluar.

<br/>

3. Desain Sistem:
   - Entity: Petugas dapur (E4)
   - Data Store:
     - Pengguna (DS1)
     - Role (DS2)
     - Warung (DS3)
     - Menu (DS4)
     - Transaksi (DS5)
     - Pelanggan (DS6)
     - Promosi (DS7)

<br/>

4. Process:
   <br/>
   Sistem POS (P0), didekomposisi menjadi:
   - Pengecekan Akses Sistem (P1)
   - Pengelolaan Data (P2)
   - Pencatatan Transaksi Penjualan (P3)

<br/>

5. Data Flow
   E1, E2, E3, dan E4 dapat memasukkan data login untuk akses P1 dan catatan terkait login dapat disimpan di DS1.

<br/>

6. Desain Antar Muka:
   - D1. Halaman Log In
   - D2. Halaman Dashboard
   - D3. Halaman Transaksi
     - Terdapat tombol tambah transaksi
     - Terdapat daftar transaksi yang dibuat shift tersebut
   - D5. Halaman Detail Transaksi
     - Halaman ini muncul ketika salah satu daftar transaksi dipilih
     - Terdapat daftar rekap pesanan dan informasi status
     - Terdapat tombol ubah status
     - Terdapat pilihan pembayaran
     - Terdapat tombol selesaikan pesanan

<br/>

7. Desain Basis Data
   - Pengguna: idpengguna, username, password, namapengguna, idrole, status (aktif/tidak), foto
   - AktivitasPengguna: idaktivitas, tanggal, waktu, idpengguna, aktivitas (login, akses shift, logout)
   - Role: idrole, role, status (aktif/tidak)
   - Warung: idwarung, namawarung, logo, gambar
   - Meja: idmeja, idwarung, kodemeja
   - Menu: idmenu, namamenu, kategori (makanan/minuman), harga, gambar
   - Transaksi: idtransaksi, tanggal, waktu, shift (1/2), idpengguna, idpelanggan (nullable), status (baru, diproses, disajikan, selesai), kodemeja, namapelanggan, total, metodepembayaran (cash, kartu debit, kartu kredit, qris), totaldiskon, idpromosi (nullable)
   - DetailTransaksi: idtransaksi, idmenu, namamenu, harga, jumlah, subtotal, status (aktif/batal)
   - Pelanggan: idpelanggan, namapelanggan, tanggaldaftar, waktudaftar, poin, status (aktif/tidak)
   - PoinTransaksi: idpointransaksi, tanggal, waktu, idpelanggan, jumlahpoin, status (tambah/kurang), poinawal, poinakhir, sumber (transaksi/promosi)
   - Promosi: idpromosi, namapromosi, deskripsi, jumlahpoin, gambar

<br/>

## Contributor

[Adri Audifirst](https://github.com/hanyaseorangpelajar), [Muhammad Haikal Ali](https://github.com/haikalassegaf), [Reza Hilmi Dafa](https://github.com/RezaHD0)

<br/>

<p align=center>Dibuat Penuh dengan 💖 oleh Kami</p>
