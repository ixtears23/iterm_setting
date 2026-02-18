#!/usr/bin/env bash
# scripts/utils.sh - 공통 유틸 함수

# 색상 코드
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

command_exists() {
    command -v "$1" &>/dev/null
}

brew_install() {
    local package="$1"
    local cask="${2:-}" # "cask"를 넘기면 --cask 설치

    if [[ "$cask" == "cask" ]]; then
        if brew list --cask "$package" &>/dev/null; then
            log_success "$package 이미 설치됨 (cask)"
            return 0
        fi
        log_info "$package 설치 중 (cask)..."
        brew install --cask "$package"
    else
        if brew list "$package" &>/dev/null; then
            log_success "$package 이미 설치됨"
            return 0
        fi
        log_info "$package 설치 중..."
        brew install "$package"
    fi
}
