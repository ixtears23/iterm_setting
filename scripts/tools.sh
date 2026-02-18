#!/usr/bin/env bash
# scripts/tools.sh - CLI 도구 설치

setup_tools() {
    log_info "=== CLI 도구 설치 ==="

    local tools=(
        fzf
        ripgrep
        bat
        eza
        fd
        git-delta
        tldr
        zoxide
        jq
        yq
        htop
        tree
        lazygit
        neovim
        gh
        tmux
    )

    for tool in "${tools[@]}"; do
        brew_install "$tool"
    done

    # fzf 키바인딩 및 자동완성 설치
    if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
        log_info "fzf 키바인딩 설치 중..."
        "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    fi

    log_success "CLI 도구 설치 완료"
}
