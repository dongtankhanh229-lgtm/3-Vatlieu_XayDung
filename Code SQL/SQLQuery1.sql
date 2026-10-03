-- 1. BẢNG NHÓM SẢN PHẨM
CREATE TABLE NhomSanPham (
    MaNhom INT IDENTITY(1,1) PRIMARY KEY,
    TenNhom NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX)
);

-- 2. BẢNG SẢN PHẨM
CREATE TABLE SanPham (
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(150) NOT NULL,
    MaNhom INT NOT NULL,
    DonViTinh NVARCHAR(30) NOT NULL,
    GiaNhapDuyet DECIMAL(15, 2) DEFAULT 0,
    GiaBanLe DECIMAL(15, 2) DEFAULT 0,
    GiaBanSile DECIMAL(15, 2) DEFAULT 0,
    MoTa NVARCHAR(MAX),
    CONSTRAINT FK_SanPham_NhomSanPham FOREIGN KEY (MaNhom) REFERENCES NhomSanPham(MaNhom)
);

-- 3. BẢNG NHÀ CUNG CẤP
CREATE TABLE NhaCungCap (
    MaNhaCungCap INT IDENTITY(1,1) PRIMARY KEY,
    TenNhaCungCap NVARCHAR(150) NOT NULL,
    NguoiLienHe NVARCHAR(100),
    SoDienThoai VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    DiaChi NVARCHAR(MAX),
    MaSoThue VARCHAR(20)
);

-- 4. BẢNG KHO HÀNG
CREATE TABLE Kho (
    MaKho INT IDENTITY(1,1) PRIMARY KEY,
    TenKho NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(MAX),
    SucChuaM3 DECIMAL(10, 2)
);

-- 5. BẢNG TỒN KHO
CREATE TABLE TonKho (
    MaKho INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuongTon DECIMAL(12, 2) DEFAULT 0,
    CONSTRAINT PK_TonKho PRIMARY KEY (MaKho, MaSanPham),
    CONSTRAINT FK_TonKho_Kho FOREIGN KEY (MaKho) REFERENCES Kho(MaKho),
    CONSTRAINT FK_TonKho_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- 6. BẢNG KHÁCH HÀNG
CREATE TABLE KhachHang (
    MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    TenKhachHang NVARCHAR(150) NOT NULL,
    LoaiKhachHang NVARCHAR(50) DEFAULT N'KhachLe',
    SoDienThoai VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    DiaChiGiaoHang NVARCHAR(MAX),
    HanMucNo DECIMAL(15, 2) DEFAULT 0,
    CongNoHienTai DECIMAL(15, 2) DEFAULT 0
);

-- 7. BẢNG NHÂN VIÊN
CREATE TABLE NhanVien (
    MaNhanVien INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(50),
    SoDienThoai VARCHAR(20) NOT NULL,
    LuongCoBan DECIMAL(15, 2) DEFAULT 0
);

-- 8. BẢNG ĐƠN HÀNG
CREATE TABLE DonHang (
    MaDonHang INT IDENTITY(1,1) PRIMARY KEY,
    MaKhachHang INT NOT NULL,
    MaNhanVien INT NOT NULL,
    NgayLap DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(15, 2) DEFAULT 0,
    TrangThaiToanKhong NVARCHAR(50) DEFAULT N'ChuaThanhToan',
    TrangThaiGiaoHang NVARCHAR(50) DEFAULT N'ChuaGiao',
    DiaChiGiaoHang NVARCHAR(MAX),
    CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    CONSTRAINT FK_DonHang_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- 9. BẢNG CHI TIẾT ĐƠN HÀNG
CREATE TABLE ChiTietDonHang (
    MaChiTiet INT IDENTITY(1,1) PRIMARY KEY,
    MaDonHang INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuong DECIMAL(12, 2) NOT NULL,
    DonGia DECIMAL(15, 2) NOT NULL,
    ThanhTien AS (SoLuong * DonGia) PERSISTED,
    CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE,
    CONSTRAINT FK_ChiTietDonHang_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- 10. BẢNG PHIẾU NHẬP KHO
CREATE TABLE PhieuNhapKho (
    MaPhieuNhap INT IDENTITY(1,1) PRIMARY KEY,
    MaNhaCungCap INT NOT NULL,
    MaNhanVien INT NOT NULL,
    MaKho INT NOT NULL,
    NgayNhap DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(15, 2) DEFAULT 0,
    GhiChu NVARCHAR(MAX),
    CONSTRAINT FK_PhieuNhap_NhaCungCap FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap),
    CONSTRAINT FK_PhieuNhap_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    CONSTRAINT FK_PhieuNhap_Kho FOREIGN KEY (MaKho) REFERENCES Kho(MaKho)
);

-- 11. BẢNG CHI TIẾT PHIẾU NHẬP KHO
CREATE TABLE ChiTietPhieuNhap (
    MaChiTietNhap INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuNhap INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuong DECIMAL(12, 2) NOT NULL,
    DonGiaNhap DECIMAL(15, 2) NOT NULL,
    ThanhTien AS (SoLuong * DonGiaNhap) PERSISTED,
    CONSTRAINT FK_ChiTietPhieuNhap_PhieuNhap FOREIGN KEY (MaPhieuNhap) REFERENCES PhieuNhapKho(MaPhieuNhap) ON DELETE CASCADE,
    CONSTRAINT FK_ChiTietPhieuNhap_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);