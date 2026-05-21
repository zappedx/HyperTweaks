:: HyperTweaks 1.0.0

@echo off
setlocal EnableDelayedExpansion
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"
title HyperTweaks - Optimize your xiaomi

:: checking adb files
echo %ESC%[96m* %ESC%[96;4mHyperTweaks%ESC%[0m
echo.

for %%f in (adb.exe AdbWinApi.dll AdbWinUsbApi.dll) do (
    if not exist "%~dp0%%f" (
        echo %ESC%[97m[ERROR] Missing ADB Files.%ESC%[0m
        echo %ESC%[97m[LOG] Please follow the tutorial.%ESC%[0m
        pause >nul
        exit
    )
)
echo %ESC%[97m[LOG] Found ADB Files!%ESC%[0m

:devicecheck
adb devices | findstr /R "device$" > nul
if %errorlevel% == 0 (
    echo %ESC%[97m[LOG] Found Device!%ESC%[0m
) else (
    echo %ESC%[97m[ERROR] No device found, is ADB Debugging on?%ESC%[0m
    pause >nul
    goto devicecheck
)

:: checking hyperos version
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"
for /f "tokens=*" %%A in ('adb shell getprop ro.miui.ui.version.name') do set "OS=%%A"
if not "!OS:~0,2!"=="V8" (
    echo %ESC%[97m[ERROR] Phone is not running HyperOS 3, other versions may not be compatible, continue?%ESC%[0m
    choice /c YN /n /m "[Y/N]: "
    if errorlevel 2 exit
    if errorlevel 1 goto main
)
echo %ESC%[97m[LOG] Device is on HyperOS 3.%ESC%[0m
goto main

::tweak
:main

::change cpu/gpu level
echo %ESC%[97m[LOG] Enable better animations, advanced textures (toggle in settings), at the cost of performance?%ESC%[0m
choice /c YN /n /m "[Y/N]: "
    if errorlevel 2 goto main2

adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.computility.cpulevel 6\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.computility.gpulevel 6\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.background_blur_supported true\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"settings\" i32 1 s16 \"put system deviceLevelList v:1,c:3,g:3\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.mi_shadow_supported true\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.support_view_smoothcorner true\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.support_window_smoothcorner true\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.background_blur_status_default true\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"settings\" i32 1 s16 \"put secure linkage_state 1\" s16 \"/storage/emulated/0/log.txt\" i32 600"
adb shell "service call miui.mqsas.IMQSNative 21 i32 1 s16 \"setprop\" i32 1 s16 \"persist.sys.add_blurnoise_supported true\" s16 \"/storage/emulated/0/log.txt\" i32 600"

:main2

::anim speed
adb shell settings put global window_animation_scale 0.5
adb shell settings put global transition_animation_scale 0.5
adb shell settings put global animator_duration_scale 0.5

::hwaccel
adb shell settings put global tether_offload_disabled 0

::hwoverlay
adb shell settings put global debug.hwui.renderer skiagl
adb shell service call SurfaceFlinger 1008 i32 1

::remove bloat
for %%A in (
    com.miui.miservice
    com.miui.msa.global
    com.android.systemui.accessibility.accessibilitymenu
    com.android.dreams.phototable
    com.android.bluetoothmidiservice
    com.facebook.appmanager
    com.wingtech.sartest
    com.google.android.printservice.recommendation
    com.miui.phone.carriers.overlay.vodafone
    com.google.android.accessibility.switchaccess
    com.miui.micloudsync
    com.google.android.ondevicepersonalization.services
    com.wdstechnology.android.kryten
    com.google.android.overlay.modules.healthfitness.forframework
    com.miui.touchassistant
    com.xiaomi.joyose
    com.mediatek.lbs.em2.ui
    com.google.android.gms.location.history
    com.mediatek.voicecommand
    com.google.android.apps.tachyon
    com.goodix.fingerprint.setting
    com.miui.cloudbackup
    com.xiaomi.glgm
    com.google.android.federatedcompute
    com.xiaomi.touchservice
    com.mediatek.mdmconfig
    com.google.android.apps.youtube.music
    com.google.android.partnersetup
    com.wing.wtsarcontrol
    com.google.android.projection.gearhead
    com.google.android.feedback
    android.autoinstalls.config.Xiaomi.model
    com.miui.bugreport
    com.miui.yellowpage
    com.android.traceur
    com.google.android.apps.messaging
    com.factory.mmigroup
    org.ifaa.aidl.manager
    com.google.android.gms.supervision
    com.xiaomi.aiasst.vision
    de.telekom.tsc
    com.android.systemui.overlay.miui
    com.milink.service
    com.android.inputsettings.overlay.miui
    com.android.WingFactoryCamera
    com.google.android.apps.setupwizard.searchselector
    com.facebook.system
    com.android.microdroid.empty_payload
    com.tencent.soter.soterserver
    com.miui.daemon
    com.android.calllogbackup
    com.miui.videoplayer
    com.xiaomi.trustservice
    com.sfr.android.sfrjeux
    com.google.android.calendar
    com.ironsource.appcloud.oobe.hutchison
    com.mediatek.ygps
    com.altice.android.myapps
    com.google.android.apps.wellbeing
    com.google.android.adservices.api
    eu.xiaomi.ext
    com.miuix.editor
    com.google.android.onetimeinitializer
    com.xiaomi.mipicks
    com.miui.analytics
    com.mi.AutoTest
    com.miui.settings.rro.device.hide.statusbar.overlay
    com.miui.thirdappassistant
    com.mediatek.mdmlsample
    com.microsoftsdk.crossdeviceservicebroker
    com.xiaomi.payment
    com.xiaomi.mi_connect_service
    com.aura.oobe.vodafone
    com.mi.globalminusscreen
    com.android.managedprovisioning.overlay
    com.google.mainline.adservices
    com.orange.aura.oobe
    com.android.hotwordenrollment.okgoogle
    com.miui.player
    com.miui.cleaner
    com.miui.phrase
    com.miui.extraphoto
    com.miui.settings.rro.device.type.overlay
    com.mediatek.voiceunlock
    com.android.hotwordenrollment.xgoogle
    com.miui.accessibility
    com.miui.phone.carriers.overlay.h3g
    com.mediatek.engineermode
    com.google.android.videos
    com.xiaomi.xmsfkeeper
    com.android.chrome
    com.facebook.services
    com.google.android.apps.maps
    com.debug.loggerui
    com.google.android.as
    com.google.android.marvin.talkback
    com.google.android.apps.docs
    com.miui.misightservice
    com.miui.vsimcore
    com.microsoft.appmanager
    com.google.android.apps.safetyhub
    com.google.android.apps.restore
    com.miui.backup
    com.xiaomi.barrage
    com.xiaomi.aon
    com.google.android.apps.subscriptions.red
    com.google.android.as.oss
    com.orange.update
    com.mediatek.atmwifimeta
    com.miui.system.overlay
    com.fingerprints.optical
    com.microsoft.deviceintegrationservice
    com.miui.cloudservice
    com.mediatek.location.mtkgeofence
    com.android.providers.partnerbookmarks
    com.google.ambient.streaming
    com.dti.bouyguestelecom
) do (
    adb shell pm uninstall --user 0 %%A
)

::disable ads
adb shell settings put global ads_user_data_enabled 0
adb shell settings put global ad_id_status 2
adb shell settings put global private_dns_mode hostname
adb shell settings put global private_dns_specifier dns.adguard-dns.com

echo %ESC%[96m* %ESC%[96;4mFinished.%ESC%[0m
echo.
echo %ESC%[97mReboot your phone!!!%ESC%[0m
pause >nul
