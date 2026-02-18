#!/usr/bin/env bash
# scripts/dotfiles.sh - 설정 파일 배포

_dotfiles_configs_dir() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$(dirname "$script_dir")/configs"
}

backup_and_link() {
    local src="$1"
    local dest="$2"
    local backup_suffix=".backup.$(date +%Y%m%d%H%M%S)"

    # 기존 파일이 있으면 백업 (심링크가 아닌 경우만)
    if [[ -f "$dest" && ! -L "$dest" ]]; then
        log_warn "기존 파일 백업: ${dest} → ${dest}${backup_suffix}"
        mv "$dest" "${dest}${backup_suffix}"
    elif [[ -L "$dest" ]]; then
        rm -f "$dest"
    fi

    log_info "심링크 생성: ${src} → ${dest}"
    ln -sf "$src" "$dest"
}

setup_dotfiles() {
    log_info "=== dotfiles 배포 ==="

    local configs_dir
    configs_dir="$(_dotfiles_configs_dir)"

    # .zshrc
    backup_and_link "${configs_dir}/.zshrc" "${HOME}/.zshrc"
    log_success ".zshrc 배포 완료"

    # .p10k.zsh
    backup_and_link "${configs_dir}/.p10k.zsh" "${HOME}/.p10k.zsh"
    log_success ".p10k.zsh 배포 완료"

    # .gitconfig.delta
    backup_and_link "${configs_dir}/.gitconfig.delta" "${HOME}/.gitconfig.delta"
    log_success ".gitconfig.delta 배포 완료"

    # .gitconfig에 delta include 추가 안내
    if [[ -f "${HOME}/.gitconfig" ]]; then
        if ! grep -q "gitconfig.delta" "${HOME}/.gitconfig"; then
            log_warn ".gitconfig에 다음 설정을 추가하세요:"
            log_warn "  [include]"
            log_warn "      path = ~/.gitconfig.delta"
        fi
    else
        log_warn ".gitconfig 파일이 없습니다. delta 설정을 사용하려면:"
        log_warn "  git config --global include.path '~/.gitconfig.delta'"
    fi

    log_success "dotfiles 배포 완료"
}

reset_dotfiles() {
    log_warn "dotfiles 초기화 중..."

    local files=(.zshrc .p10k.zsh .gitconfig.delta)

    for file in "${files[@]}"; do
        local target="${HOME}/${file}"
        if [[ -L "$target" ]]; then
            rm -f "$target"
            log_success "${file} 심링크 삭제"

            # 백업 파일이 있으면 복원
            local latest_backup
            latest_backup=$(ls -t "${target}".backup.* 2>/dev/null | head -1)
            if [[ -n "$latest_backup" ]]; then
                mv "$latest_backup" "$target"
                log_success "${file} 백업에서 복원: ${latest_backup}"
            fi
        fi
    done

    log_success "dotfiles 초기화 완료"
}
