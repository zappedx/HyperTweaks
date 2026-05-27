<div align="center">
  
<img src="logo.webp" width="160" height="160" style="display: block; margin: 0 auto;" alt="icon" />

# HyperTweaks
Root olmadan cihazlar için HyperOS optimizasyonları.

[English](https://github.com/zaaaappp/HyperTweaks) - [German](/readme-de.md) - Turkish

</div>

# Hakkında
HyperTweaks, ADB tabanlı son derece basit bir batch scriptidir,
çeşitli sistem ayarlarını optimize eder.

> [!CAUTION]
> - Sadece HyperOS 3 üzerinde test edilmiştir.
> - Recovery üzerinden nasıl sıfırlama yapılacağını bildiğinden emin ol.
> - Bootloop durumlarından sorumlu değilim.

# Kurulum
> [!WARNING]
> USB hata ayıklamanın açık olduğundan emin ol, aksi halde hata verir.

Yeşil "Code" butonuna tıkla ve ardından "Download ZIP" seçeneğini seç. Daha sonra [ADB](https://dl.google.com/android/repository/platform-tools-latest-windows.zip) indir ve şu dosyaları kopyala: adb.exe, AdbWinApi.dll, AdbWinUsbApi.dll indirilen ZIP dosyasının içine. Ardından HyperTweaks.cmd dosyasını çalıştırarak telefonunu optimize et.

# Detaylı olarak ne yapar
- Çeşitli Xiaomi bloatware uygulamalarını kaldırır (birden fazla kaynakla doğrulanmıştır)
- Özel DNS etkinleştirir (dns.adguard-dns.com)
- Daha iyi animasyonlar için isteğe bağlı GPU/CPU seviyesini artırır veya düşürür
- HW Overlay devre dışı bırakılır ve tethering için donanım hızlandırma etkinleştirilir

Root olmadığı için HyperOS sınırlı şekilde optimize edilebilir.
