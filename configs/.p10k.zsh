# Powerlevel10k 설정 파일
# 기본 프리셋: lean 스타일 (Rainbow에 비해 깔끔한 느낌)
# 'p10k configure'로 인터랙티브 재설정 가능

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  autoload -Uz is-at-least && is-at-least 5.1 || return

  # 프롬프트 요소
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    dir
    vcs
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    background_jobs
    node_version
    python_version
    go_version
    java_version
    kubecontext
    context
    time
  )

  # 기본 설정
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Rainbow 스타일 (화살표 구분선)
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'

  # 프롬프트 문자
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=114
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=168
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true

  # 디렉토리
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=111
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=237
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

  # Git (VCS) — 통일 배경 + 상태별 글자 색
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=151
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=237
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=216
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=237
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=141
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=237
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=211
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=237
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=249
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=237
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '

  # 실행 시간
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=250
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=237

  # 시간
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=249
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=237
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'

  # 상태 코드
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=211
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=237

  # 백그라운드 잡
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=250
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=237

  # 컨텍스트 (user@host)
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=180
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=178
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT_EXPANSION,TEMPLATE}=
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'

  # Python
  typeset -g POWERLEVEL9K_PYTHON_VERSION_FOREGROUND=37
  typeset -g POWERLEVEL9K_PYTHON_VERSION_PROJECT_ONLY=true

  # Node
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=70
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

  # Go
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=37
  typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true

  # Java
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=32
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true

  # Kubernetes
  typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND=134
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold|kubent|kubelogin|conduit'

  # OS 아이콘
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=147
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=237

  # Transient prompt (명령 실행 후 프롬프트 간소화)
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

  # Instant prompt
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # 핫 리로드
  (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
  'builtin' 'unset' 'p10k_config_opts'
}
