create table KHOA(
    Makhoa varchar2(10) primary key,
    Tenkhoa nvarchar2(100),
    Dienthoai varchar2(10)
)

create table LOP(
    Malop varchar2(10) primary key,
    Tenlop nvarchar2(50),
    Khoa nvarchar2(50),
    Hedt nvarchar2(50),
    Namnhaphoc varchar2(15),
    Makhoa varchar2(10),
    constraint fk_LOP_KHOA foreign key (Makhoa) references KHOA(Makhoa)
)


create or replace procedure sp_ThemKhoa(maKhoa in varchar2, tenKhoa in nvarchar2, dienThoai in varchar2)
as dem number := 0;
begin
    select count(*) into dem from KHOA where Tenkhoa = tenKhoa;
    if dem > 0 then
        DBMS_OUTPUT.PUT_LINE('Thông báo: Tên khoa đã tồn tại.');
    else
        insert into KHOA(Makhoa, Tenkhoa, Dienthoai)
        values(maKhoa, tenKhoa, dienThoai);
        commit;
        DBMS_OUTPUT.PUT_LINE('Thông báo: Thêm khoa thành công');
    end if;
end;


SET SERVEROUTPUT ON


begin
    sp_themkhoa('CNTT', N'Công nghệ thông tin', '0123456789');
end;


-- test trường hợp 2
begin
    sp_themkhoa('CNTT1', N'Công nghệ thông tin', '0123456789');
end;

-- bài tập 2
create or replace procedure sp_ThemLop (
    maLop in varchar2, tenLop in nvarchar2, khoa in nvarchar2, 
    hedt in nvarchar2, namnhaphoc in number, maKhoa in varchar2
) as
    dem_lop number := 0;
    dem_khoa number := 0;
begin
    select count(*) into dem_lop from LOP where tenlop = tenlop;
    select count(*) into dem_khoa from KHOA where makhoa = makhoa;

    if dem_lop > 0 then
        DBMS_OUTPUT.PUT_LINE('Thông báo: Tên lớp đã tồn tại');
    elsif dem_khoa = 0 then
        DBMS_OUTPUT.PUT_LINE('Thông báo: Mã khoa không tồn tại trong bảng KHOA');
    else
        insert into LOP (malop, tenlop, khoa, hedt, namnhaphoc, makhoa)
        values (malop, tenlop, khoa, hedt, namnhaphoc, makhoa);
        commit;
        DBMS_OUTPUT.PUT_LINE('Thông báo: Thêm lớp thành công');
    end if;
end;


-- bài tập 3
create or replace procedure sp_ThemKhoa_out (
    maKhoa in varchar2, tenKhoa in nvarchar2, dienThoai in varchar2,
    ketqua out number
) as
    dem number;
begin
    select count(*) into dem from KHOA where Tenkhoa = tenKhoa;
    if dem > 0 then
        ketqua := 0;
    else
        insert into KHOA values (maKhoa, tenKhoa, dienThoai);
        commit;
        ketqua := 1;
    end if;
end;


-- bài tập 4
create or replace procedure sp_ThemLop_out (
    malop in varchar2, 
    tenlop in nvarchar2, 
    khoa in nvarchar2, 
    hedt in nvarchar2, 
    namnhaphoc in varchar2,
    maKhoa in varchar2,
    ketQua out number
) as
    dem_lop number; 
    dem_khoa number;
begin
    select count(*) into dem_lop from lop where tenlop = tenlop;
    select count(*) into dem_khoa from khoa where makhoa = makhoa;

    if dem_lop > 0 then
        ketqua := 0;
    elsif dem_khoa = 0 then
        ketqua := 1;
    else
        insert into lop values (malop, tenlop, khoa, hedt, namnhaphoc, makhoa);
        commit;
        ketQua := 2;
    end if;
end;

---------- phiếu bài tập 2
create table tblChucVu (
    MaCV varchar2(10) primary key, 
    TenCV nvarchar2(50)
);

create table tblNhanVien (
    MaNV varchar2(10) primary key, 
    MaCV varchar2(10),
    TenNV nvarchar2(50),
    NgaySinh date, 
    LuongCanBan number(10, 2), 
    NgayCong number(5, 2),
    PhuCap number(10, 2),
    constraint fk_macv foreign key (MaCV) references tblChucVu(macv)
);



