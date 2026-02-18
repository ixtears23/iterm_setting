#!/usr/bin/env bash
# install.sh - iTerm2 파워 유저 세팅 자동화 메인 스크립트
#
# 사용법:
#   ./install.sh          # 일반 설치
#   ./install.sh --reset  # 기존 설정 초기화 후 재설치

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 모듈 로드
source "${SCRIPT_DIR}/scripts/utils.sh"
source "${SCRIPT_DIR}/scripts/brew.sh"
source "${SCRIPT_DIR}/scripts/fonts.sh"
source "${SCRIPT_DIR}/scripts/zsh.sh"
source "${SCRIPT_DIR}/scripts/tools.sh"
source "${SCRIPT_DIR}/scripts/iterm2.sh"
source "${SCRIPT_DIR}/scripts/dotfiles.sh"

# --reset 플래그 확인
RESET_MODE=false
if [[ "${1:-}" == "--reset" ]]; then
    RESET_MODE=true
fi

echo ""
echo "============================================"
echo "   iTerm2 파워 유저 세팅 자동화 스크립트"
echo "============================================"
echo ""

if [[ "$RESET_MODE" == true ]]; then
    log_warn "⚠️  리셋 모드: 기존 설정을 초기화하고 새로 설치합니다."
    echo ""
    read -r -p "정말로 기존 설정을 초기화하시겠습니까? (y/N): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        log_info "설치를 취소합니다."
        exit 0
    fi

    echo ""
    log_info "기존 설정 초기화 중..."
    reset_dotfiles
    reset_zsh
    reset_iterm2
    echo ""
    log_success "초기화 완료. 새로 설치를 시작합니다."
    echo ""
else
    log_info "설치를 시작합니다. (기존 설정이 있으면 건너뜁니다)"
    echo ""
    read -r -p "계속하시겠습니까? (Y/n): " confirm
    if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
        log_info "설치를 취소합니다."
        exit 0
    fi
    echo ""
fi

# 1. Homebrew
setup_brew
echo ""

# 2. 폰트
setup_fonts
echo ""

# 3. Zsh 환경
setup_zsh
echo ""

# 4. CLI 도구
setup_tools
echo ""

# 5. iTerm2
setup_iterm2
echo ""

# 6. dotfiles 배포
setup_dotfiles
echo ""

echo "============================================"
log_success "모든 설치가 완료되었습니다!"
echo "============================================"
echo ""
log_info "다음 단계:"
log_info "  1. iTerm2를 재시작하세요"
log_info "  2. Powerlevel10k 설정을 변경하려면: p10k configure"
log_info "  3. 새 터미널을 열어 설정을 확인하세요"
echo ""
