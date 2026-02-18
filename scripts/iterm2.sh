#!/usr/bin/env bash
# scripts/iterm2.sh - iTerm2 설치 및 설정

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
THEMES_DIR="${PROJECT_DIR}/themes"
ITERM_PLIST="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"
PLISTBUDDY="/usr/libexec/PlistBuddy"

download_catppuccin_theme() {
    local theme_file="${THEMES_DIR}/catppuccin-mocha.itermcolors"

    if [[ -f "$theme_file" ]]; then
        log_success "Catppuccin Mocha 테마 이미 다운로드됨"
        return 0
    fi

    log_info "Catppuccin Mocha 테마 다운로드 중..."
    curl -fsSL -o "$theme_file" \
        "https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-mocha.itermcolors"

    if [[ -f "$theme_file" ]]; then
        log_success "Catppuccin Mocha 테마 다운로드 완료"
    else
        log_error "테마 다운로드 실패"
        return 1
    fi
}

import_iterm_theme() {
    local theme_file="${THEMES_DIR}/catppuccin-mocha.itermcolors"

    if [[ ! -f "$theme_file" ]]; then
        log_error "테마 파일이 없습니다: $theme_file"
        return 1
    fi

    log_info "iTerm2에 Catppuccin Mocha 테마 임포트 중..."
    open "$theme_file"
    sleep 2
    log_success "테마 임포트 완료 (iTerm2에서 확인 필요)"
}

configure_iterm_profile() {
    log_info "iTerm2 프로필 설정 중..."

    # iTerm2가 한 번이라도 실행된 적이 있어야 plist가 존재
    if [[ ! -f "$ITERM_PLIST" ]]; then
        log_warn "iTerm2 plist가 없습니다. iTerm2를 한 번 실행한 후 다시 시도하세요."
        return 1
    fi

    local PROFILE_PATH=":New Bookmarks:0"

    # 폰트 설정: MesloLGS NF 14pt
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Normal Font\" MesloLGS-NF-Regular 14" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Normal Font\" string MesloLGS-NF-Regular 14" "$ITERM_PLIST"

    # Non-ASCII 폰트도 동일하게
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Non Ascii Font\" MesloLGS-NF-Regular 14" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Non Ascii Font\" string MesloLGS-NF-Regular 14" "$ITERM_PLIST"

    # 투명도 (0.05 = 약간 투명)
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:Transparency 0.05" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:Transparency real 0.05" "$ITERM_PLIST"

    # 블러
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Blur\" true" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Blur\" bool true" "$ITERM_PLIST"

    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Blur Radius\" 5" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Blur Radius\" real 5" "$ITERM_PLIST"

    # 무제한 스크롤백
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Unlimited Scrollback\" true" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Unlimited Scrollback\" bool true" "$ITERM_PLIST"

    # 커서: Vertical Bar (1), Blinking
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Cursor Type\" 1" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Cursor Type\" integer 1" "$ITERM_PLIST"

    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Blinking Cursor\" true" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Blinking Cursor\" bool true" "$ITERM_PLIST"

    # Option 키 → Esc+ (Meta) (2 = Esc+)
    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Option Key Sends\" 2" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Option Key Sends\" integer 2" "$ITERM_PLIST"

    $PLISTBUDDY -c "Set ${PROFILE_PATH}:\"Right Option Key Sends\" 2" "$ITERM_PLIST" 2>/dev/null ||
        $PLISTBUDDY -c "Add ${PROFILE_PATH}:\"Right Option Key Sends\" integer 2" "$ITERM_PLIST"

    log_success "iTerm2 프로필 설정 완료"
}

install_shell_integration() {
    local integration_file="${HOME}/.iterm2_shell_integration.zsh"

    if [[ -f "$integration_file" ]]; then
        log_success "iTerm2 Shell Integration 이미 설치됨"
        return 0
    fi

    log_info "iTerm2 Shell Integration 설치 중..."
    curl -fsSL https://iterm2.com/shell_integration/zsh -o "$integration_file"

    if [[ -f "$integration_file" ]]; then
        log_success "iTerm2 Shell Integration 설치 완료"
    else
        log_error "Shell Integration 설치 실패"
    fi
}

setup_iterm2() {
    log_info "=== iTerm2 설정 ==="

    brew_install "iterm2" "cask"
    download_catppuccin_theme
    configure_iterm_profile
    import_iterm_theme
    install_shell_integration

    log_success "iTerm2 설정 완료"
}

reset_iterm2() {
    log_warn "iTerm2 설정 초기화 중..."

    if [[ -f "$ITERM_PLIST" ]]; then
        rm -f "$ITERM_PLIST"
        log_success "iTerm2 plist 삭제 완료"
    fi

    rm -f "${HOME}/.iterm2_shell_integration.zsh"
    log_success "iTerm2 설정 초기화 완료"
}
