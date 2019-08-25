```bash
adb shell \(cd /mnt/sdcard\; rm -rf NPKI\)
adb shell \(cd /mnt/sdcard\; mkdir -p NPKI\)

adb push SignKorea.tar /mnt/sdcard/NPKI
adb shell \(cd /mnt/sdcard/NPKI\; tar xf SignKorea.tar\; ls SignKorea/USER\)

adb push yessign.tar /mnt/sdcard/NPKI
adb shell \(cd /mnt/sdcard/NPKI\; tar xf yessign.tar\; ls yessign/USER\)
```
