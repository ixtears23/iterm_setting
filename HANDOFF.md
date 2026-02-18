# HANDOFF.md

세션 간 작업 인수인계 파일. 새 세션 시작 시 이 파일을 먼저 읽는다.

## 마지막 작업 세션

- **날짜**: 2026-02-18
- **상태**: P10k 색상 테마 Catppuccin 톤 적용 완료

## 완료된 작업

- [x] Git 저장소 초기화
- [x] remote origin 설정 (`git@github.com-ixtears23:ixtears23/iterm_setting.git`)
- [x] local git user 설정 (JunseokOh / ixtears23@icloud.com)
- [x] CLAUDE.md 작성 (프로젝트 개요, 커밋 규칙, 파일 운영 규칙)
- [x] HANDOFF.md, CHANGELOG.md 생성
- [x] `scripts/utils.sh` - 공통 유틸 함수 (log, command_exists, brew_install)
- [x] `scripts/brew.sh` - Homebrew 설치/업데이트 모듈
- [x] `scripts/fonts.sh` - MesloLGS Nerd Font 설치 모듈
- [x] `scripts/zsh.sh` - Oh My Zsh + Powerlevel10k + 플러그인 모듈
- [x] `scripts/tools.sh` - CLI 도구 16종 설치 모듈
- [x] `scripts/iterm2.sh` - iTerm2 설치 + 테마 + 프로필 설정 모듈
- [x] `scripts/dotfiles.sh` - dotfiles 배포/백업/복원 모듈
- [x] `configs/.zshrc` - Zsh 설정 파일
- [x] `configs/.p10k.zsh` - Powerlevel10k 설정
- [x] `configs/.gitconfig.delta` - git-delta 설정
- [x] `install.sh` - 메인 설치 스크립트 (일반/리셋 모드)

## 진행 중인 작업

- `configs/.zshrc`에 npm PATH 추가 변경이 미커밋 상태

## 다음에 할 작업

- `configs/.zshrc` npm PATH 변경 커밋 여부 결정
- 실제 환경에서 `./install.sh` 테스트 실행
- `./install.sh --reset` 초기화 후 재설치 테스트
- iTerm2 재시작 후 테마, 폰트, 키맵핑 적용 확인
- 필요에 따라 configs/ 파일 튜닝

## 프로젝트 구조

```
iterm_setting/
├── install.sh              # 메인 진입점
├── scripts/
│   ├── utils.sh            # 공통 유틸
│   ├── brew.sh             # Homebrew
│   ├── fonts.sh            # Nerd Font
│   ├── zsh.sh              # Oh My Zsh + P10k + 플러그인
│   ├── tools.sh            # CLI 도구
│   ├── iterm2.sh           # iTerm2 설정
│   └── dotfiles.sh         # dotfiles 배포
├── configs/
│   ├── .zshrc              # Zsh 설정
│   ├── .p10k.zsh           # P10k 설정
│   └── .gitconfig.delta    # git-delta 설정
├── themes/                 # iTerm2 컬러 테마 (런타임에 다운로드)
├── CLAUDE.md
├── HANDOFF.md
└── CHANGELOG.md
```

## 참고 사항

- SSH config에서 GitHub Host alias는 `github.com-ixtears23` (키: `~/.ssh/id_ed25519_ixtears23`)
- 커밋 메시지는 한국어, 형식은 `#이슈번호 [타입] 제목` (CLAUDE.md 참고)
- Catppuccin Mocha 테마는 install.sh 실행 시 자동 다운로드됨
- `--reset` 플래그로 전체 초기화 후 재설치 가능
