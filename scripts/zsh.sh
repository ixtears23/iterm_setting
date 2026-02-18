#!/usr/bin/env bash
# scripts/zsh.sh - Oh My Zsh + Powerlevel10k + 플러그인 설치

setup_zsh() {
    log_info "=== Zsh 환경 설정 ==="

    local ZSH_DIR="${HOME}/.oh-my-zsh"
    local ZSH_CUSTOM="${ZSH_DIR}/custom"

    # Oh My Zsh 설치
    if [[ -d "$ZSH_DIR" ]]; then
        log_success "Oh My Zsh 이미 설치됨"
    else
        log_info "Oh My Zsh 설치 중..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Powerlevel10k 테마
    local P10K_DIR="${ZSH_CUSTOM}/themes/powerlevel10k"
    if [[ -d "$P10K_DIR" ]]; then
        log_success "Powerlevel10k 이미 설치됨"
    else
        log_info "Powerlevel10k 설치 중..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    fi

    # zsh-autosuggestions
    local AUTOSUG_DIR="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    if [[ -d "$AUTOSUG_DIR" ]]; then
        log_success "zsh-autosuggestions 이미 설치됨"
    else
        log_info "zsh-autosuggestions 설치 중..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUG_DIR"
    fi

    # zsh-syntax-highlighting
    local SYNHI_DIR="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    if [[ -d "$SYNHI_DIR" ]]; then
        log_success "zsh-syntax-highlighting 이미 설치됨"
    else
        log_info "zsh-syntax-highlighting 설치 중..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNHI_DIR"
    fi

    # zsh-completions
    local COMP_DIR="${ZSH_CUSTOM}/plugins/zsh-completions"
    if [[ -d "$COMP_DIR" ]]; then
        log_success "zsh-completions 이미 설치됨"
    else
        log_info "zsh-completions 설치 중..."
        git clone https://github.com/zsh-users/zsh-completions "$COMP_DIR"
    fi

    log_success "Zsh 환경 설정 완료"
}

reset_zsh() {
    log_warn "Zsh 환경 초기화 중..."
    rm -rf "${HOME}/.oh-my-zsh"
    log_success "Oh My Zsh 삭제 완료"
}
