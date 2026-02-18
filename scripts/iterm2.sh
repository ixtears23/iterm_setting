#!/usr/bin/env bash
# scripts/iterm2.sh - iTerm2 설치 및 설정

_iterm_script_dir() { cd "$(dirname "${BASH_SOURCE[0]}")" && pwd; }
_iterm_project_dir() { dirname "$(_iterm_script_dir)"; }

ITERM_PLIST="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"
PLISTBUDDY="/usr/libexec/PlistBuddy"

download_catppuccin_theme() {
    local themes_dir="$(_iterm_project_dir)/themes"
    local theme_file="${themes_dir}/catppuccin-mocha.itermcolors"

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
    local themes_dir="$(_iterm_project_dir)/themes"
    local theme_file="${themes_dir}/catppuccin-mocha.itermcolors"

    if [[ ! -f "$theme_file" ]]; then
        log_error "테마 파일이 없습니다: $theme_file"
        return 1
    fi

    log_info "iTerm2에 Catppuccin Mocha 테마 임포트 중..."
    open "$theme_file" 2>/dev/null || true
    sleep 2
    log_success "테마 임포트 완료 (iTerm2에서 확인 필요)"
}

configure_iterm_profile() {
    log_info "iTerm2 프로필 설정 중..."

    # iTerm2가 한 번이라도 실행된 적이 있어야 plist가 존재
    if [[ ! -f "$ITERM_PLIST" ]]; then
        log_warn "iTerm2 plist가 없습니다. iTerm2를 먼저 실행합니다..."
        open -a iTerm
        sleep 3
        killall iTerm2 2>/dev/null || true
        sleep 1
    fi

    if [[ ! -f "$ITERM_PLIST" ]]; then
        log_warn "iTerm2 plist를 찾을 수 없습니다. 프로필 설정을 건너뜁니다."
        log_warn "iTerm2를 수동으로 한 번 실행한 후 install.sh를 다시 실행하세요."
        return 0
    fi

    local PROFILE_PATH=":New Bookmarks:0"

    # PlistBuddy 안전 래퍼: Set 시도 → 실패 시 Add
    _plist_set() {
        local key="$1" type="$2" value="$3"
        $PLISTBUDDY -c "Set ${PROFILE_PATH}:${key} ${value}" "$ITERM_PLIST" 2>/dev/null ||
            $PLISTBUDDY -c "Add ${PROFILE_PATH}:${key} ${type} ${value}" "$ITERM_PLIST" 2>/dev/null || true
    }

    _plist_set '"Normal Font"' string "MesloLGS-NF-Regular 14"
    _plist_set '"Non Ascii Font"' string "MesloLGS-NF-Regular 14"
    _plist_set "Transparency" real "0.05"
    _plist_set '"Blur"' bool "true"
    _plist_set '"Blur Radius"' real "5"
    _plist_set '"Unlimited Scrollback"' bool "true"
    _plist_set '"Cursor Type"' integer "1"
    _plist_set '"Blinking Cursor"' bool "true"
    _plist_set '"Option Key Sends"' integer "2"
    _plist_set '"Right Option Key Sends"' integer "2"

    unset -f _plist_set
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
