FROM gitlab/gitlab-ce:latest AS base

ARG DEV_gitlab

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_SRC=/src \
    PIPENV_HIDE_EMOJIS=true \
    NO_COLOR=true \
    PIPENV_NOSPIN=true

RUN mkdir -p /app
WORKDIR /app
EXPOSE 80

# System dependencies
RUN apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install -y \
        'vim'

# Pip and pipenv
# RUN pip install --upgrade pip
# RUN pip install pipenv

# Some package stuff
COPY setup.py ./
COPY src/gitlab/__init__.py src/gitlab/__init__.py

# Install dependencies
# COPY Pipfile Pipfile.lock ./
# RUN --mount=source=.git,target=.git,type=bind \
#     pipenv install --system --deploy --ignore-pipfile --dev

# Run the jupyter lab server
# RUN mkdir -p /run_scripts
# COPY /bash_scripts/docker_entry /run_scripts
# RUN chmod +x /run_scripts/*
# CMD ["/bin/bash", "/run_scripts/docker_entry"]