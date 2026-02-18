#!/usr/bin/env bash
# scripts/fonts.sh - Nerd Font 설치

setup_fonts() {
    log_info "=== 폰트 설정 ==="

    brew_install "font-meslo-lg-nerd-font" "cask"

    log_success "폰트 설정 완료"
}
