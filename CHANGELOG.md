# CHANGELOG.md

모든 주요 변경 사항을 이 파일에 기록한다.

## 2026-02-18

### 추가

- `README.md`: GitHub README 작성 (설치 방법, 설치 항목, 프로젝트 구조)
- `configs/.zshrc`: npm 글로벌 패키지 PATH 추가

### 변경

- `configs/.p10k.zsh`: Powerlevel10k 색상 테마를 Catppuccin Mocha 톤으로 변경
  - 세그먼트 배경을 통일된 짙은 회색(237)으로 설정
  - 디렉토리, Git 상태, 프롬프트 문자 등 글자 색을 Catppuccin 팔레트로 적용
  - Rainbow 스타일 화살표 구분선 명시적 설정

### 최초 추가

- iTerm2 파워 유저 세팅 자동화 스크립트 전체 구현
  - `install.sh`: 메인 설치 스크립트 (일반 설치 / --reset 초기화 모드)
  - `scripts/utils.sh`: 공통 유틸 함수 (로그, 명령어 체크, brew 래퍼)
  - `scripts/brew.sh`: Homebrew 설치 및 업데이트 모듈
  - `scripts/fonts.sh`: MesloLGS Nerd Font 설치 모듈
  - `scripts/zsh.sh`: Oh My Zsh + Powerlevel10k + 플러그인 설치 모듈
  - `scripts/tools.sh`: CLI 도구 16종 설치 모듈 (fzf, ripgrep, bat, eza 등)
  - `scripts/iterm2.sh`: iTerm2 설치 + Catppuccin Mocha 테마 + 프로필 설정 모듈
  - `scripts/dotfiles.sh`: 설정 파일 심링크 배포 및 백업/복원 모듈
  - `configs/.zshrc`: Zsh 설정 파일 (P10k, 앨리어스, FZF, 도구 초기화)
  - `configs/.p10k.zsh`: Powerlevel10k lean 프리셋 설정
  - `configs/.gitconfig.delta`: git-delta 설정 (side-by-side diff)
  - `themes/`: Catppuccin Mocha 테마 저장 디렉토리

- 프로젝트 초기 구성
  - `CLAUDE.md`: Claude Code 작업 규칙 및 커밋 규칙 정의
  - `HANDOFF.md`: 세션 간 인수인계 파일 생성
  - `CHANGELOG.md`: 변경 이력 파일 생성
  - `.claude/settings.local.json`: Claude Code 권한 설정
