#!/bin/bash
# Author: Lawkmu
# 42login: mouait-e

set -e

# Banner
clear
echo -e "\n\033[1;34m███████╗██╗   ██╗██████╗ ███████╗██╗   ██╗███████╗\033[0m"
echo -e "\033[1;34m██╔════╝██║   ██║██╔══██╗██╔════╝██║   ██║██╔════╝\033[0m"
echo -e "\033[1;34m█████╗  ██║   ██║██████╔╝█████╗  ██║   ██║███████╗\033[0m"
echo -e "\033[1;34m██╔══╝  ██║   ██║██╔═══╝ ██╔══╝  ╚██╗ ██╔╝╚════██║\033[0m"
echo -e "\033[1;34m██║     ╚██████╔╝██║     ███████╗ ╚████╔╝ ███████║\033[0m"
echo -e "\033[1;34m╚═╝      ╚═════╝ ╚═╝     ╚══════╝  ╚═══╝  ╚══════╝\033[0m"
echo -e "\n\033[32m        Full Ubuntu 42 Session Cleaner\033[0m"
sleep 1

# Helpers
print_storage() {
    local label=$1
    free_space=$(df -h "$HOME" | awk 'NR==2 {print $4}')
    echo -e "\033[32m -- $label Storage: || $free_space || --\n\033[0m"
}

should_log=0
full_clean=0
docker_clean=0

# Parse args
for arg in "$@"; do
  case $arg in
    -p|--print)
      should_log=1
      ;;
    --full)
      full_clean=1
      ;;
    --docker)
      docker_clean=1
      ;;
    *)
      ;;
  esac
done

function clean_glob {
    [ -z "$1" ] && return 0

    if [ $should_log -eq 1 ]; then
        for arg in "$@"; do
            du -sh "$arg" 2>/dev/null
        done
    fi

    /bin/rm -rf "$@" &>/dev/null
}

# Basic cleaning (user session garbage)
function basic_clean {
    echo -e "\033[33m\n -- Cleaning user session junk ... --\033[0m"
    shopt -s nullglob

    # Trash
    clean_glob "$HOME"/.local/share/Trash/files/*
    clean_glob "$HOME"/.local/share/Trash/info/*

    # Application caches
    clean_glob "$HOME"/.cache/*
    clean_glob "$HOME"/.mozilla/firefox/*.default-release/cache2/*
    clean_glob "$HOME"/.config/google-chrome/Default/Service\ Worker/CacheStorage/*
    clean_glob "$HOME"/.config/google-chrome/Default/Application\ Cache/*
    clean_glob "$HOME"/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/*
    clean_glob "$HOME"/.config/BraveSoftware/Brave-Browser/Default/Application\ Cache/*
    clean_glob "$HOME"/.config/discord/Cache/*
    clean_glob "$HOME"/.config/Slack/Cache/*
    clean_glob "$HOME"/.config/Code/Cache/*
    clean_glob "$HOME"/.config/Code/CachedData/*
    clean_glob "$HOME"/Downloads/*~

    # VSCode workspace storage
    clean_glob "$HOME"/.config/Code/User/workspaceStorage/*
}

# Function to check sudo availability
function check_sudo {
    if sudo -n true 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Full cleaning (system-wide)
function full_cleaning {
    echo -e "\033[33m\n -- Attempting Full System Clean... --\033[0m"

    if ! check_sudo; then
        echo -e "\033[31m\n⚠️  Full cleaning requires sudo permissions.\033[0m"
        echo -e "\033[31mYou are running in a restricted environment (like 42 session).\nSkipping full system clean.\033[0m\n"
        return 1
    fi

    # If sudo available, proceed with full clean
    sudo apt clean -y &>/dev/null
    sudo journalctl --vacuum-time=1d &>/dev/null
    sudo rm -rf /var/tmp/* /tmp/* &>/dev/null
    sudo rm -rf /var/log/*.gz /var/log/*.[0-9] &>/dev/null

    echo -e "\033[32m\n✅ Full System Clean completed!\033[0m"
}


# Docker cleaning
function docker_cleaning {
    if command -v docker &>/dev/null; then
        echo -e "\033[36m\n -- Cleaning Docker system ... --\033[0m"
        docker system prune -af --volumes
    else
        echo -e "\033[31m\n -- Docker not installed, skipping --\033[0m"
    fi
}

# MAIN
print_storage "Available Before Cleaning"

basic_clean

if [ $full_clean -eq 1 ]; then
    full_cleaning
fi

if [ $docker_clean -eq 1 ]; then
    docker_cleaning
fi

print_storage "Available After Cleaning"

echo -e "\n\033[33m -- Cleaning complete! Enjoy a fresh Ubuntu session! --\033[0m"

echo -e	"\nReport issues:"
echo -e "  GitHub  ~> \033[4;1;34mlawkmu\033[0m"

