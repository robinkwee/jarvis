#!/bin/bash
# GeniBot — Startup Script
# Manages docker container lifecycle for GENAIO project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRAIN_PATH="${GENAIO_BRAIN_PATH:-$SCRIPT_DIR/brain}"
CONTAINER_NAME="genaio-bot"
PORT="8003"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
GeniBot Container Manager

Usage: ./start.sh [command]

Commands:
  start       Start the container (default)
  stop        Stop the container
  restart     Restart the container
  logs        Show live logs
  status      Show container status
  shell       Open bash shell in container
  brain       Show brain directory listing
  clean       Remove container (preserves brain)
  help        Show this help

Examples:
  ./start.sh start
  ./start.sh logs -f
  ./start.sh status
EOF
}

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✅${NC} $1"
}

log_error() {
    echo -e "${RED}❌${NC} $1"
}

ensure_docker() {
    if ! command -v docker &> /dev/null; then
        log_error "Docker not found. Please install Docker first."
        exit 1
    fi

    if ! docker ps &> /dev/null; then
        log_error "Cannot connect to Docker daemon. Check permissions or run: newgrp docker"
        exit 1
    fi
}

cmd_start() {
    ensure_docker

    if [ ! -d "$BRAIN_PATH" ]; then
        log_error "Brain path not found: $BRAIN_PATH"
        exit 1
    fi

    log_info "Starting GeniBot..."
    log_info "Brain: $BRAIN_PATH"
    log_info "Port: $PORT"

    export GENAIO_BRAIN_PATH="$BRAIN_PATH"
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" up -d

    sleep 2
    log_success "GeniBot started"
    cmd_status

    echo ""
    echo "📚 Access your brain:"
    echo "  http://localhost:$PORT/"
    echo ""
    echo "View logs:"
    echo "  ./start.sh logs -f"
}

cmd_stop() {
    ensure_docker
    log_info "Stopping GeniBot..."
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" down
    log_success "Stopped"
}

cmd_restart() {
    cmd_stop
    sleep 1
    cmd_start
}

cmd_logs() {
    ensure_docker
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" logs "$@"
}

cmd_status() {
    ensure_docker
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" ps

    echo ""
    echo "Memory usage:"
    docker stats $CONTAINER_NAME --no-stream 2>/dev/null || echo "Container not running"
}

cmd_shell() {
    ensure_docker
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" exec genaio-bot /bin/bash
}

cmd_brain() {
    log_info "Brain directory: $BRAIN_PATH"
    echo ""
    find "$BRAIN_PATH" -type f -name "*.md" 2>/dev/null | head -20 || echo "No markdown files found"
    echo ""
    echo "Total files:"
    find "$BRAIN_PATH" -type f | wc -l
}

cmd_clean() {
    ensure_docker
    log_info "Removing container (brain preserved)..."
    docker compose -f "$SCRIPT_DIR/docker-compose.yml" down -v
    log_success "Container removed. Brain preserved at: $BRAIN_PATH"
}

# Main
COMMAND="${1:-start}"

case "$COMMAND" in
    start)
        cmd_start
        ;;
    stop)
        cmd_stop
        ;;
    restart)
        cmd_restart
        ;;
    logs)
        shift
        cmd_logs "$@"
        ;;
    status)
        cmd_status
        ;;
    shell)
        cmd_shell
        ;;
    brain)
        cmd_brain
        ;;
    clean)
        cmd_clean
        ;;
    help|-h|--help)
        usage
        ;;
    *)
        log_error "Unknown command: $COMMAND"
        echo ""
        usage
        exit 1
        ;;
esac
