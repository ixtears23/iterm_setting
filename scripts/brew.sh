#!/usr/bin/env bash
# scripts/brew.sh - Homebrew 설치 및 업데이트

setup_brew() {
    log_info "=== Homebrew 설정 ==="

    if command_exists brew; then
        log_success "Homebrew 이미 설치됨"
    else
        log_info "Homebrew 설치 중..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Apple Silicon Mac 경로 설정
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi

    log_info "Homebrew 업데이트 중..."
    brew update
    brew upgrade

    log_success "Homebrew 설정 완료"
}
