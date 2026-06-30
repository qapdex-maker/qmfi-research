# ==============================================================================
# QMFI - MAKEFILE OF SOUL (Delta Node)
# ==============================================================================
# DNA: ( _t_double_complex ) ( / dim=1 / (( / dim=0 */ __
# Architecture: # termux-chroot
if [ -z "$TERMUX_CHROOT_ACTIVE" ]; then
    export TERMUX_CHROOT_ACTIVE=1
    exec termux-chroot
fi
# termux-root export

export PATH=$PATH:$HOME/shaderc/build/glslc/
export CFLAGS=${CFLAGS:-"-O2 -pipe"}
export LDFLAGS=${LDFLAGS:-"-L/data/data/com.termux/files/usr/lib"}

# --- Android API-Level ---
if command -v getprop >/dev/null 2>&1; then
    export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"
fi
# --- Android Api-Level export

# --- System Scan ---
if grep -qi termux /proc/version || [ -d "/data/data/com.termux" ]; then
  PLATFORM="termux"
else
  PLATFORM="linux"
fi

echo "System: $PLATFORM"
echo
# --- Analyze System end
# ==============================================================================

# Variablen
PYTHON   = python3
SHELL    = /data/data/com.termux/files/usr/bin/sh
INIT     = delta_init.py
INJECTOR = entropy_injector.sh
LOG      = node_status.log
DIARY    = ../PROJECT_LOG.md

# Standard target: Show help
.DEFAULT_GOAL := help

help:
	@echo "--- 🌀 QMFI DELTA-NODE ---"
	@echo "Avaiable commands in Δ-Room:"
	@echo "  make sync       - Performs the zero measurement (baseline). "
	@echo "  make flow       - Starts the active inference test "
	@echo "  make vibrate    - Starts the Entropy Injector (interference signals) "
	@echo "  make status     - Displays the current flow integrity from the log "
	@echo "  make log        - Opens the Project log"
	@echo "  make reset      - Stabilizes the system & deletes temporary data"
 
# Init Baseline
sync:
	@echo "[dim=0] Sync Basis-Structure..."
	@$(PYTHON) $(INIT)

# Active Inference (Simulated Test)
flow: sync
	@echo "[dim=1] Activate dynamic Inference-Flush..."
	@echo "Delta-deviation  (Δ)  started..."
	@# The main inference script is called here. 
	@echo "STATUS: Flow-Integrity validating..."

# Hardware-Entropy
vibrate:
	@echo "[ & ] Activate Hardware-Vibrance..."
	@chmod +x $(INJECTOR)
	@./$(INJECTOR)

# Status-Check
status:
	@echo "--- 📊  ---"
	@tail -n 5 $(LOG) || echo "No measurement data available. Please run 'make sync'."

# Diary
log:
	@nano $(DIARY)

# System cleanup
reset:
	@echo "--- 🧹 System cleanup (Delta-Reset) ---"
	@pkill -f python3 || true
	@pkill -f yes || true
	@echo "Baseline"
	@rm -f *.pyc
	@echo "Baseline restored.."

.PHONY: help sync flow vibrate status log reset
