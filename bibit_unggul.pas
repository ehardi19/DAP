program penjualan_bibit_tanaman_buah;
{IS. Terdefinisi array kosong dari data bibit, data transaksi, dan data laporan
 FS. Menjalankan program penjualan bibit buah sesuai dengan menu yang disediakan}
uses crt;
{======================== DEKLARASI TIPE BENTUKAN =============================}
{ARRAY 1: DATA BIBIT}
Type
ket = record
    asal : string;
    thn_panen : integer;
    harga : longint;
    stok : integer;
    sold : array[1..12] of integer;
end;
Type
jenis = record
  nama_jenis : string;
  keterangan : ket;
end;
Type
buah = record
  nama_buah : string;
  jenis : array [1..100] of jenis;
end;
Type
pot = array [1..100] of buah;
{ARRAY 2: TRANSAKSI}
Type
times = record
  tgl : integer;
  bln : integer;
  thn : integer;
end;
Type
list = record
  buah : string;
  jenis : string;
  jum_beli : integer;
  harga_sat : longint;
  tot_harga : longint;
end;
Type
beli = record
  nama : string;
  tgl_beli : times;
  list_beli : array [1..100] of list;
  tot_akhir : longint;
end;
Type
struk = array [1..100] of beli;
{ARRAY 3: LAPORAN}
Type laporan = array[1..12] of longint;
{=========================== DEKLARASI VARIABEL ===============================}
Var
  bibit : pot; //array1
  transaksi : struk; //array2
  bulanan : laporan;// array3
  i,a : integer;
  pilihan, pil : integer;
  tanya : char;
{================================= FUNCTION ===================================}
function countBuah(bbt : pot):integer;
{Menghitung banyak data di array buah}
var
  i : integer;
begin
  i:=1;
  while (bbt[i].nama_buah<>'') do
    i:=i+1;
  countBuah:=i-1;
end;
function countJenis(bbt : pot; i : integer):integer;
{Menghitung banyak data di array jenis}
var
  j : integer;
begin
  j:=1;
  while (bbt[i].jenis[j].nama_jenis<>'') do
    j:=j+1;
  countJenis:=j-1;
end;
function countTrans(tsaksi : struk):integer;
{Menghitung banyak data di array transaksi}
var
  a : integer;
begin
  a:=1;
  while(tsaksi[a].nama<>'') do
    a:=a+1;
  countTrans:=a-1;
end;
function countBeli(tsaksi : struk; a : integer):integer;
{Menghitung banyak data di array list beli}
var
  b : integer;
begin
  b:=1;
  while (tsaksi[a].list_beli[b].jum_beli<>0) do
    b:=b+1;
  countBeli:=b-1;
end;
function cekStok(n : integer; bbt : pot; i,j : integer):boolean;
{Mengecek stok bibit dari array 1}
begin
  if (n<=bbt[i].jenis[j].keterangan.stok) then
    cekStok:=true
  else
    cekStok:=false;
end;
{================================= PROCEDURE ==================================}
{--------------------------------- MENU 1 -------------------------------------}
Procedure input(var bbt : pot; var i : integer);
{Menginputkan data untuk array 1: data bibit}
var
  j : integer;
  tanya1,tanya2 : string;
begin
  repeat
    if (bbt[i].nama_buah<>'') then
     i:=i+1;
    clrscr;
    writeln('DATA BUAH KE-',i);
    write('Nama Buah : ');
    readln(bbt[i].nama_buah);
    j:=1;
    repeat
      clrscr;
      writeln('DATA BUAH KE-',i);
      writeln('Nama Buah : ',bbt[i].nama_buah);
      writeln('JENIS KE-',j);
      write('1. Nama Jenis : ');
      readln(bbt[i].jenis[j].nama_jenis);
      writeln('2. Keterangan');
      write(' A. Asal Negara         : ');
      readln(bbt[i].jenis[j].keterangan.asal);
      write(' B. Tahun Mulai Panen   : ');
      readln(bbt[i].jenis[j].keterangan.thn_panen);
      write(' C. Harga Satuan        : ');
      readln(bbt[i].jenis[j].keterangan.harga);
      write(' D. Stok                : ');
      readln(bbt[i].jenis[j].keterangan.stok);
      j:=j+1;
      writeln;
      write('Ingin menambahkan jenis lagi ? [Y/T] : ');
      readln(tanya2);
      writeln;
    until(tanya2='T') or (tanya2='t');
    write('Ingin menambahkan buah lagi ? [Y/T]  : ');
    readln(tanya1);
    writeln;
  until(tanya1='T') or (tanya1='t');
end;
{--------------------------------- MENU 2 -------------------------------------}
{Part of Menu 2}
Procedure show(bbt : pot);
{Menampilkan data array 1: data bibit}
var
  i,j : integer;
  maxi,maxj : integer;
begin
  clrscr;
  maxi:=countBuah(bbt);
  i:=1;
  while (i<=maxi) do
  begin
    clrscr;
    writeln('BUAH KE-',i);
    writeln('Nama Buah : ',bbt[i].nama_buah);
    writeln;
    j:=1;
    maxj:=countJenis(bbt,i);
    while (j<=maxj) do
    begin
      writeln('JENIS KE-',j);
      writeln(' A. Nama Jenis           : ',bbt[i].jenis[j].nama_jenis);
      writeln(' B. Asal                 : ',bbt[i].jenis[j].keterangan.asal);
      writeln(' C. Tahun Mulai Panen    : ',bbt[i].jenis[j].keterangan.thn_panen);
      writeln(' D. Harga Satuan         : ',bbt[i].jenis[j].keterangan.harga);
      writeln(' E. Stok                 : ',bbt[i].jenis[j].keterangan.stok);
      readln;
      j:=j+1;
    end;
    if (i<>maxi) then
    begin
      writeln('Press <ENTER> to see next data..');
      readln;
    end;
    i:=i+1;
  end;
end;
{Menu 2}
{Menu 2 Pilihan 1}
procedure sort_harga(bbt : pot);
{Mengurutkan berdasarkan harga dari tertinggi ke terendah}
var
  i,sizei,sizej,a,b,max : integer;
  temp : jenis;
begin
  sizei:=countBuah(bbt);
  for i:=1 to sizei do
  begin
    sizej:=countJenis(bbt,i);
    for a:=1 to sizej-1 do
    begin
      max:=a;
      for b:=a+1 to sizej do
      begin
        if(bbt[i].jenis[b].keterangan.harga)>(bbt[i].jenis[max].keterangan.harga) then
          max:=b;
      end;
      temp:=bbt[i].jenis[max];
      bbt[i].jenis[max]:=bbt[i].jenis[a];
      bbt[i].jenis[a]:=temp;
    end;
  end;
  show(bbt);
end;
{Menu 2 Pilihan 2}
procedure sort_stok(bbt : pot);
{Mengurutkan berdasarkan jumlah stok dari tertinggi ke terendah}
var
  i,sizei,sizej,a,b,max : integer;
  temp : jenis;
begin
  sizei:=countBuah(bbt);
  for i:=1 to sizei do
  begin
    sizej:=countJenis(bbt,i);
    for a:=1 to sizej-1 do
    begin
      max:=a;
      for b:=a+1 to sizej do
      begin
        if(bbt[i].jenis[b].keterangan.stok)>(bbt[i].jenis[max].keterangan.stok) then
          max:=b;
      end;
      temp:=bbt[i].jenis[max];
      bbt[i].jenis[max]:=bbt[i].jenis[a];
      bbt[i].jenis[a]:=temp;
    end;
  end;
  show(bbt);
end;
{--------------------------------- MENU 3 -------------------------------------}
{Part of Menu 3}
Procedure searchBuah(bbt : pot; x : string; var found : boolean; var i : integer);
{Mencari data berdasarkan nama buah di array 1: data bibit}
var
  maxi:integer;
begin
  maxi:=countBuah(bbt);
  i:=1;
  while (i<maxi) and (bbt[i].nama_buah<>x) do
    i:=i+1;
  if (bbt[i].nama_buah=x) then
    found:=true
  else
    found:=false;
end;
Procedure searchJenis(bbt : pot; i : integer; x : string; var found : boolean; var j : integer);
{Mencari data berdasarkan nama jenis di array 1: data bibit}
var
  maxj:integer;
begin
  maxj:=countJenis(bbt,i);
  j:=1;
  while (j<maxj) and (bbt[i].jenis[j].nama_jenis<>x) do
    j:=j+1;
  if (bbt[i].jenis[j].nama_jenis=x) then
    found:=true
  else
    found:=false;
end;
Procedure delete(var bbt : pot; i,j : integer);
{Menghapus data jenis di array 1: data bibit}
begin
  bbt[i].jenis[j].nama_jenis:='';
  bbt[i].jenis[j].keterangan.asal:='';
  bbt[i].jenis[j].keterangan.thn_panen:=0;
  bbt[i].jenis[j].keterangan.harga:=0;
  bbt[i].jenis[j].keterangan.stok:=0;
end;
procedure tambahJenis(var bbt : pot; i : integer);
{Menambahkan data jenis di array 1: data bibit}
var
  j,maxj : integer;
  tanya : char;
begin
  maxj:=countJenis(bbt,i);
  j:=maxj+1;
  clrscr;
  repeat
    clrscr;
    writeln('DATA BUAH KE-',i);
    writeln('Nama Buah : ',bbt[i].nama_buah);
    writeln('JENIS KE-',j);
    write('1. Nama Jenis           : ');
    readln(bbt[i].jenis[j].nama_jenis);
    writeln('2. Keterangan');
    write(' A. Asal Negara         : ');
    readln(bbt[i].jenis[j].keterangan.asal);
    write(' B. Tahun Mulai Panen   : ');
    readln(bbt[i].jenis[j].keterangan.thn_panen);
    write(' C. Harga Satuan        : ');
    readln(bbt[i].jenis[j].keterangan.harga);
    write(' D. Stok                : ');
    readln(bbt[i].jenis[j].keterangan.stok);
    j:=j+1;
    writeln;
    write('Ingin menambahkan jenis lagi ? [Y/T] : ');
    readln(tanya);
  until(tanya='T') or (tanya='t');
end;
procedure editJenis(var bbt : pot; var i : integer);
{Mengedit data jenis pada buah tertentu di array 1: data bibit}
var
  j,maxj,tempj : integer;
  xJenis : string;
  foundJenis : boolean;
  pil : integer;
  tanya : char;
begin
  repeat
    clrscr;
    write('Masukkan nama jenis yang ingin diedit : ');
    readln(xJenis);
    writeln;
    searchJenis(bbt,i,xJenis,foundJenis,j);
    if foundJenis=true then
    begin
      writeln('Data ditemukan pada indeks ke-',j);
      writeln('=============================');
      writeln('     MENU EDIT');
      writeln('=============================');
      writeln('1. Edit Nama Jenis');
      writeln('2. Edit Asal Negara');
      writeln('3. Edit Tahun Mulai Panen');
      writeln('4. Edit Harga Satuan');
      writeln('5. Edit Stok');
      writeln('6. Hapus Data Jenis');
      writeln('7. Back to previous menu');
      writeln('=============================');
      write('Masukkan pilihan anda : ');
      readln(pil);
      writeln;
      case pil of
      1 : begin
            write('Nama Jenis : ');
            readln(bbt[i].jenis[j].nama_jenis);
          end;
      2 : begin
            write('Asal Negara : ');
            readln(bbt[i].jenis[j].keterangan.asal);
          end;
      3 : begin
            write('Tahun Mulai Panen : ');
            readln(bbt[i].jenis[j].keterangan.thn_panen);
          end;
      4 : begin
            write('Harga Satuan : ');
            readln(bbt[i].jenis[j].keterangan.harga);
          end;
      5 : begin
            write('Stok : ');
            readln(bbt[i].jenis[j].keterangan.stok);
          end;
      6 : begin
            maxj:=countJenis(bbt,i);
            delete(bbt,i,j);
            if (j<maxj) then
            begin
              for tempj:=j to maxj do
                bbt[i].jenis[tempj]:=bbt[i].jenis[tempj+1];
            end;
          end;
      end;
    end
    else
      writeln('Data tidak ditemukan');
    writeln;
    write('Lakukan pengeditan untuk jenis lain ? [Y/T] : ');
    readln(tanya);
  until (tanya='T') or (tanya='t') or (pil=7);
end;
{Menu 3}
Procedure editData (var bbt : pot);
{Mengedit data buah tertentu di array 1: data bibit}
var
  xBuah : string;
  foundBuah : boolean;
  i,j : integer;
  pil : integer;
  maxi,maxj,tempi : integer;
  tanya : char;
begin
  repeat
  clrscr;
    write('Masukkan nama buah yang ingin diedit : ');
    readln(xBuah);
    writeln;
    searchBuah(bbt,xBuah,foundBuah,i);
    if foundBuah=true then
    begin
      writeln('Data ditemukan pada indeks ke-',i);
      writeln;
      writeln('=============================');
      writeln('     MENU EDIT');
      writeln('=============================');
      writeln('1. Edit Nama Buah');
      writeln('2. Tambahkan Data Jenis');
      writeln('3. Edit Data Jenis');
      writeln('4. Hapus Data Buah');
      writeln('5. Back to main menu');
      writeln('=============================');
      write('Masukkan pilihan anda : ');
      readln(pil);
      writeln;
      case pil of
      1 : begin
            write('Nama Buah : ');
            readln(bbt[i].nama_buah);
          end;
      2 : begin
            tambahJenis(bbt,i);
          end;
      3 : begin
            editJenis(bbt,i);
          end;
      4 : begin
            maxi:=countBuah(bbt);
            bbt[i].nama_buah:='';
            maxj:=countJenis(bbt,i);
            for j:=1 to maxj do
              delete(bbt,i,j);
            if (i<maxi) then
            begin
              for tempi:=i to maxi do
                bbt[tempi]:=bbt[tempi+1];
            end;
          end;
      end;
    end
    else
      writeln('Data tidak ditemukan');
    writeln;
    write('Lakukan pengeditan untuk buah lain ? [Y/T] : ');
    readln(tanya);
    writeln;
  until (tanya='T') or (tanya='t') or (pil=5);
end;
{--------------------------------- MENU 4 -------------------------------------}
{Part of Menu 4}
procedure showBeli(tsaksi : struk; a : integer);
{Menampilkan list beli pada transaksi}
var
  b : integer;
begin
  b:=1;
  while (tsaksi[a].list_beli[b].buah<>'') do
  begin
    writeln('ITEM KE-',b);
    writeln;
    writeln('Jenis Bibit Buah               : ',tsaksi[a].list_beli[b].buah,' ',tsaksi[a].list_beli[b].jenis);
    writeln('Jumlah Pembelian               : ',tsaksi[a].list_beli[b].jum_beli);
    writeln('Harga Satuan                   : ',tsaksi[a].list_beli[b].harga_sat);
    writeln('Total Harga                    : ',tsaksi[a].list_beli[b].tot_harga);
    readln;
    b:=b+1;
  end;
  readln;
end;
{Menu 4}
Procedure transaction(var bbt : pot; var tsaksi : struk; var month : laporan; var a : integer);
{Melakukan proses transaksi untuk mengisi array 2: transaksi}
var
  buah,jenis : string;
  foundBuah,foundJenis : boolean;
  i,j,b : integer;
  nama : string;
  tgl,bln : integer;
  jum_beli : integer;
  cek_stok : boolean;
  confirm,again : char;
Begin
  clrscr;
  a:=a+1;
  b:=1;
  repeat
    if (b=1) then
    begin
      tsaksi[a].list_beli[b].tot_harga:=0;
      writeln('DATA PEMBELI');
      writeln('------------------------------------');
      write('Nama Pembeli         : ');
      readln(nama);
      writeln('------------------------------------');
      writeln('Taanggal Pembelian');
      writeln('------------------------------------');
      write('Tanggal              : ');
      readln(tgl);
      write('Bulan                : ');
      readln(bln);
      writeln('Tahun                : 2017');
      writeln('------------------------------------');
      readln;
      tsaksi[a].nama:=nama;
      tsaksi[a].tgl_beli.tgl:=tgl;
      tsaksi[a].tgl_beli.bln:=bln;
      tsaksi[a].tgl_beli.thn:=2017; //asumsi semua transaksi pada tahun 2017
    end;
    writeln;
    clrscr;
    writeln('PENCARIAN BIBIT');
    writeln('------------------------------------');
    write('Masukkan nama buah  : ');
    readln(buah);
    write('Masukkan jenis buah : ');
    readln(jenis);
    writeln;
    searchBuah(bbt,buah,foundBuah,i);
    if (foundBuah=true) then
    begin
      searchJenis(bbt,i,jenis,foundJenis,j);
      if (foundJenis=true) then
      begin
        {Show}
        clrscr;
        if (bbt[i].jenis[j].keterangan.stok>0) then
        begin
          writeln('Nama Jenis Bibit Buah  : ',bbt[i].nama_buah,' ',bbt[i].jenis[j].nama_jenis);
          writeln('Asal                   : ',bbt[i].jenis[j].keterangan.asal);
          writeln('Tahun Mulai Panen      : ',bbt[i].jenis[j].keterangan.thn_panen);
          writeln('Harga Satuan           : ',bbt[i].jenis[j].keterangan.harga);
          writeln('Stok                   : ',bbt[i].jenis[j].keterangan.stok);
          writeln;
          write('Masukkan ke keranjang belanjaan ? [Y/T] : ');
          readln(confirm);
          writeln;
          if (confirm='Y') or (confirm='y') then
          begin
            repeat
              clrscr;
              writeln('ITEM KE-',b);
              writeln('Stok yang tersedia ',bbt[i].jenis[j].keterangan.stok);
              writeln;
              writeln('Nama Pembeli                   : ',tsaksi[a].nama);
              writeln('Tanggal Pembelian [DD/MM/YYYY] : ',tsaksi[a].tgl_beli.tgl,'/',tsaksi[a].tgl_beli.bln,'/',tsaksi[a].tgl_beli.thn);
              writeln('Jenis Bibit Buah               : ',bbt[i].nama_buah,' ',bbt[i].jenis[j].nama_jenis);
              write('Jumlah Pembelian               : ');
              readln(jum_beli);
              writeln;
              cek_stok:=cekStok(jum_beli,bbt,i,j);
              if (cek_stok=true) then
              begin
                tsaksi[a].list_beli[b].buah:=buah;
                tsaksi[a].list_beli[b].jenis:=jenis;
                tsaksi[a].list_beli[b].jum_beli:=jum_beli;
                tsaksi[a].list_beli[b].harga_sat:=bbt[i].jenis[j].keterangan.harga;
                tsaksi[a].list_beli[b].tot_harga:=tsaksi[a].list_beli[b].harga_sat*tsaksi[a].list_beli[b].jum_beli;
                tsaksi[a].tot_akhir:=tsaksi[a].tot_akhir+tsaksi[a].list_beli[b].tot_harga;
                bbt[i].jenis[j].keterangan.stok:=bbt[i].jenis[j].keterangan.stok-tsaksi[a].list_beli[b].jum_beli;
                bbt[i].jenis[j].keterangan.sold[bln]:=tsaksi[a].list_beli[b].jum_beli;
                month[bln]:=month[bln]+tsaksi[a].tot_akhir;
                b:=b+1;
              end
              else
              begin
                writeln('Maaf stok tidak memadai, silakan masukkan kembali jumlah pembelian anda');
                readln;
              end;
            until (cek_stok=true);
          end;
        end
        else
        begin
          writeln('Maaf stok untuk sementara kosong');
          writeln;
        end;
      end
      else
      begin
        writeln('Bibit jenis buah yang anda cari tidak tersedia');
        writeln;
      end;
    end
    else
    begin
      writeln('Bibit jenis buah yang anda cari tidak tersedia');
      writeln;
    end;
    write('Lakukan transaksi lainnya ? ');
    readln(again);
  until (again='T') or (again='t');
  if (tsaksi[a].tot_akhir=0) then
  begin
    clrscr;
    tsaksi[a].nama:='';
    tsaksi[a].tgl_beli.tgl:=0;
    tsaksi[a].tgl_beli.bln:=0;
    tsaksi[a].tgl_beli.thn:=0;
    writeln('Tidak ada data pembelian, transaksi dibatalkan');
  end
  else
  begin
    clrscr;
    writeln('                          STRUK PEMBELIAN');
    writeln('=====================================================================');
    writeln('Nama Pembeli                   : ',tsaksi[a].nama);
    writeln('Tanggal Pembelian [DD/MM/YYYY] : ',tsaksi[a].tgl_beli.tgl,'/',tsaksi[a].tgl_beli.bln,'/',tsaksi[a].tgl_beli.thn);
    writeln('---------------------------------------------------------------------');
    showBeli(tsaksi,a);
    writeln('---------------------------------------------------------------------');
    writeln('Total Akhir                    : ',tsaksi[a].tot_akhir);
  end;
  readln;
End;
{--------------------------------- MENU 5 -------------------------------------}
Procedure showTransaksi(tsaksi : struk);
{Menampilkan data pada array 2: transaksi}
var
  i : integer;
  maxi : integer;
begin
  clrscr;
  maxi:=countTrans(tsaksi);
  i:=1;
  while (i<=maxi) do
  begin
    clrscr;
    writeln('=====================================================================');
    writeln('TRANSAKSI KE-',i);
    writeln('=====================================================================');
    writeln('Nama Pembeli : ',tsaksi[i].nama);
    writeln('Tanggal Pembelian : ',tsaksi[i].tgl_beli.tgl,'/',tsaksi[i].tgl_beli.bln,'/',tsaksi[i].tgl_beli.thn);
    writeln('---------------------------------------------------------------------');
    showBeli(tsaksi,i);
    writeln('---------------------------------------------------------------------');
    writeln('Total Akhir : ',tsaksi[i].tot_akhir);
    writeln('=====================================================================');
    readln;
    if (i<>maxi) then
    begin
      writeln('Press <ENTER> to see next data..');
      readln;
    end;
    i:=i+1;
  end;
end;
{--------------------------------- MENU 6 -------------------------------------}
Procedure showSold(bbt : pot; month : laporan);
{Menampilkan data penjualan array 1}
var
  i,j : integer;
  bln : integer;
begin
  clrscr;
  for bln:=1 to 12 do
  begin
    i:=1;
    while (bbt[i].nama_buah<>'') do
    begin
      clrscr;
      writeln('===============================================');
      case bln of
        1 : writeln('DATA PENJUALAN BULAN JANUARI');
        2 : writeln('DATA PENJUALAN BULAN FEBRUARI');
        3 : writeln('DATA PENJUALAN BULAN MARET');
        4 : writeln('DATA PENJUALAN BULAN APRIL');
        5 : writeln('DATA PENJUALAN BULAN MEI');
        6 : writeln('DATA PENJUALAN BULAN JUNI');
        7 : writeln('DATA PENJUALAN BULAN JULI');
        8 : writeln('DATA PENJUALAN BULAN AGUSTUS');
        9 : writeln('DATA PENJUALAN BULAN SEPTEMBER');
        10 : writeln('DATA PENJUALAN BULAN OKTOBER');
        11 : writeln('DATA PENJUALAN BULAN NOVEMBER');
        12 : writeln('DATA PENJUALAN BULAN DESEMBER');
      end;
      writeln('===============================================');
      writeln('BUAH KE-',i);
      writeln('Nama Buah : ',bbt[i].nama_buah);
      writeln;
      j:=1;
      while (bbt[i].jenis[j].nama_jenis<>'') do
      begin
        writeln('JENIS KE-',j);
        writeln(' A. Nama Jenis           : ',bbt[i].jenis[j].nama_jenis);
        writeln(' B. Terjual              : ',bbt[i].jenis[j].keterangan.sold[bln]);
        writeln(' C. Pendapatan           : ',bbt[i].jenis[j].keterangan.sold[bln]*bbt[i].jenis[j].keterangan.harga);
        readln;
        j:=j+1;
      end;
      if (bbt[i+1].nama_buah<>'') then
      begin
        writeln('Press <ENTER> to see next data..');
        readln;
      end;
      i:=i+1;
    end;
    writeln('===============================================');
    case bln of
      1 : writeln('TOTAL PEMASUKAN BULAN JANUARI : ',month[1]);
      2 : writeln('TOTAL PEMASUKAN BULAN FEBRUARI : ',month[2]);
      3 : writeln('TOTAL PEMASUKAN BULAN MARET : ',month[3]);
      4 : writeln('TOTAL PEMASUKAN BULAN APRIL : ',month[4]);
      5 : writeln('TOTAL PEMASUKAN BULAN MEI : ',month[5]);
      6 : writeln('TOTAL PEMASUKAN BULAN JUNI : ',month[6]);
      7 : writeln('TOTAL PEMASUKAN BULAN JULI : ',month[7]);
      8 : writeln('TOTAL PEMASUKAN BULAN AGUSTUS : ',month[8]);
      9 : writeln('TOTAL PEMASUKAN BULAN SEPTEMBER : ',month[9]);
      10 : writeln('TOTAL PEMASUKAN BULAN OKTOBER : ',month[10]);
      11 : writeln('TOTAL PEMASUKAN BULAN NOVEMBER : ',month[11]);
      12 : writeln('TOTAL PEMASUKAN BULAN DESEMBER : ',month[12]);
    end;
    writeln('===============================================');
    readln;
  end;
  writeln('Press <ENTER> to see complete sales report in 2017');
  readln;
end;
{Menu 6}
Procedure report(bbt : pot; tsaksi : struk; month : laporan);
{Melaporkan pemasukan per bulan pada tahun 2017}
begin
  showSold(bbt,month);
  clrscr;
  writeln('=====================================================================');
  writeln ('LAPORAN PEMASUKAN PENJUALAN BIBIT BUAH TAHUN 2017');
  writeln('=====================================================================');
  writeln('JANUARI   : ',month[1]);
  writeln('FEBRUARI  : ',month[2]);
  writeln('MARET     : ',month[3]);
  writeln('APRIL     : ',month[4]);
  writeln('MEI       : ',month[5]);
  writeln('JUNI      : ',month[6]);
  writeln('JULI      : ',month[7]);
  writeln('AGUSTUS   : ',month[8]);
  writeln('SEPTEMBER : ',month[9]);
  writeln('OKTOBER   : ',month[10]);
  writeln('NOVEMBER  : ',month[11]);
  writeln('DESEMBER  : ',month[12]);
  writeln('=====================================================================');
  writeln('TOTAL     : ',month[1]+month[2]+month[3]+month[4]+month[5]+month[6]+month[7]+month[8]+month[9]+month[10]+month[11]+month[12]);
  writeln('=====================================================================');
  readln;
end;
{--------------------------------- TRANSISI -----------------------------------}
Procedure opsi (var tanya : char);
{Transisi untuk kembali ke menu utama atau keluar}
begin
  writeln('Press any button to go to main menu..');
  writeln('Press <X> button to exit..');
  readln(tanya);
end;
{=============================== PROGRAM UTAMA ================================}
BEGIN
  clrscr;
  i:=0;
  a:=0;
  repeat
    clrscr;
    writeln('===================================');
    writeln('             MAIN MENU');
    writeln('===================================');
    writeln('1. Input Data Bibit');
    writeln('2. Tampilkan Data Bibit');
    writeln('3. Edit Data Bibit');
    writeln('4. Lakukan Tranaksi');
    writeln('5. Tampilkan Data Tranaksi');
    writeln('6. Laporan Penjualan');
    writeln('7. Exit');
    writeln('===================================');
    write('Masukkan pilihan anda : ');
    readln(pilihan);
    case pilihan of
    1 : begin
          input(bibit,i);
          opsi(tanya);
        end;
    2 : begin
          repeat
            clrscr;
            writeln('=============================');
            writeln('          MENU SHOW');
            writeln('=============================');
            writeln('1. Sorting berdasarkan harga');
            writeln('2. Sorting berdasarkan stok');
            writeln('3. Back to main menu');
            writeln('=============================');
            write('Masukkan pilihan anda : ');
            readln(pil);
            writeln;
            case pil of
            1 : begin
                  sort_harga(bibit);
                end;
            2 : begin
                  sort_stok(bibit);
                end;
            end;
          until (pil=3);
          opsi(tanya);
        end;
    3 : begin
          editData(bibit);
          opsi(tanya);
        end;
    4 : begin
          transaction(bibit,transaksi,bulanan,a);
          opsi(tanya);
        end;
    5 : begin
          showTransaksi(transaksi);
          opsi(tanya);
        end;
    6 : begin
          report(bibit,transaksi,bulanan);
          opsi(tanya);
        end;
    end;
  until(tanya='X') or (tanya='x') or (pilihan=7);
END.
