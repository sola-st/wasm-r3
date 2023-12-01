# TODO

1. Sometimes when running the online tessuite something like this comes and crashes the testsuite:

boa  |node:internal/process/promises:289
            triggerUncaughtException(err, true /* fromPromise */);
            ^

route.fetch: Browser closed.
==================== Browser output: ====================
<launching> /Users/jakob/Library/Caches/ms-playwright/chromium-1084/chrome-mac/Chromium.app/Contents/MacOS/Chromium --disable-field-trial-config --disable-background-networking --enable-features=NetworkService,NetworkServiceInProcess --disable-background-timer-throttling --disable-backgrounding-occluded-windows --disable-back-forward-cache --disable-breakpad --disable-client-side-phishing-detection --disable-component-extensions-with-background-pages --disable-component-update --no-default-browser-check --disable-default-apps --disable-dev-shm-usage --disable-extensions --disable-features=ImprovedCookieControls,LazyFrameLoading,GlobalMediaControls,DestroyProfileOnBrowserClose,MediaRouter,DialMediaRouteProvider,AcceptCHFrame,AutoExpandDetailsElement,CertificateTransparencyComponentUpdater,AvoidUnnecessaryBeforeUnloadCheckSync,Translate --allow-pre-commit-input --disable-hang-monitor --disable-ipc-flooding-protection --disable-popup-blocking --disable-prompt-on-repost --disable-renderer-backgrounding --force-color-profile=srgb --metrics-recording-only --no-first-run --enable-automation --password-store=basic --use-mock-keychain --no-service-autorun --export-tagged-pdf --disable-search-engine-choice-screen --enable-use-zoom-for-dsf=false --use-angle --headless --hide-scrollbars --mute-audio --blink-settings=primaryHoverType=2,availableHoverTypes=2,primaryPointerType=4,availablePointerTypes=4 --no-sandbox --disable-web-security --js-flags="--max_old_space_size=8192" --user-data-dir=/var/folders/db/66bvcjvn5795vhkkt3klcxdw0000gn/T/playwright_chromiumdev_profile-k9IWao --remote-debugging-pipe --no-startup-window
<launched> pid=29372
[pid=29372][err] 2023-12-02 01:34:54.623 Chromium Helper (Renderer)[29376:235929] CoreText note: Client requested name ".NewYork-Regular", it will get TimesNewRomanPSMT rather than the intended font. All system UI font access should be through proper APIs such as CTFontCreateUIFontForLanguage() or +[NSFont systemFontOfSize:].
[pid=29372][err] 2023-12-02 01:34:54.623 Chromium Helper (Renderer)[29376:235929] CoreText note: Set a breakpoint on CTFontLogSystemFontNameRequest to debug.
[pid=29372] <gracefully close start>
    at /Users/jakob/Desktop/wasm-r3/dist/src/analyser.cjs:38:42 {
  name: 'Error'
}

2.