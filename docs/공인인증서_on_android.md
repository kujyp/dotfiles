```bash
adb shell \(cd /mnt/sdcard\; rm -rf NPKI\)
adb shell \(cd /mnt/sdcard\; mkdir -p NPKI\)

adb push SignKorea.tar /mnt/sdcard/NPKI
adb shell \(cd /mnt/sdcard/NPKI\; ls SignKorea/USER\)
adb shell \(cd /mnt/sdcard/NPKI\; tar xf SignKorea.tar\; ls SignKorea/USER\)

cd /Users/jaeyoung/google_drive/영구공유/공인인증서
if [[ ! -f yessign.tar ]]; then
    tar cvf yessign.tar yessign
fi
cd /Users/jaeyoung/google_drive/영구공유/공인인증서
adb push yessign.tar /mnt/sdcard/NPKI
adb shell \(cd /mnt/sdcard/NPKI\; tar xf yessign.tar\; ls yessign/USER\; rm -f yessign.tar\)
```
