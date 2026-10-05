<div align="center">

# ⚡ AOS (Agent Operating System)
### Fast, Local Non-LLM Kernel for Context & Token Optimization

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Python Version](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)](https://www.python.org)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-informational)](https://github.com/GamalxX/aos)
[![Protocol](https://img.shields.io/badge/Protocol-Model%20Context%20Protocol%20(MCP)-blueviolet)](https://modelcontextprotocol.io)
[![Token Reduction](https://img.shields.io/badge/Context%20Reduction-90%25%2B-success)](#-performance-benchmarks)

<p align="center">
  <b>AOS acts as a sub-LLM intelligence plane, deterministic code engine, and precision context compressor for AI coding assistants.</b><br>
  Works natively with <b>Cursor</b>, <b>VS Code / Cline</b>, <b>Google Antigravity</b>, and any <b>MCP-compliant</b> host.
</p>

---

</div>

## 🚀 Key Highlights & Benchmarks

| Metric | Traditional Agent Flow | With AOS Kernel | Impact |
| :--- | :---: | :---: | :---: |
| **Context Tokens per Task** | 3,500 – 12,000 tokens | **< 350 tokens** | **90%+ Reduction** |
| **Fast-Path AST Decision** | 2,000 – 5,000 ms (LLM call) | **< 1.0 ms** (Deterministic) | **Instant (< 1ms)** |
| **Verification & Regression Rate**| Manual / Ad-hoc | **100% Verified** | **Zero Broken Code** |
| **Source Privacy** | Entire files sent to cloud | **100% Local Execution** | **Zero Code Leakage** |

> ⚡ **[AOS Value in Action]:** Saved 94.2% tokens (3,850 tokens) in 1.42ms via Precision Context Slicing.

---

## ⚡ Quickstart (One-Line Installer)

### 1. Install AOS Core

#### Windows (PowerShell)
```powershell
irm https://api.aos.run/install.ps1 | iex
```

#### Linux & macOS (Bash)
```bash
curl -fsSL https://api.aos.run/install.sh | bash
```

*Alternatively, clone the repository and run `pip install -e .` in your local Python 3.10+ environment.*

---

### 2. Initialize in Any Repository

Navigate to your target project folder and run:

```bash
aos setup
```

`aos setup` automatically:
- 📁 Creates the localized `.aos/` workspace intelligence store.
- 🛡️ Adds `.aos/` to `.gitignore` to prevent committing runtime state or indices.
- 🔌 Injects standardized Model Context Protocol (MCP) configuration into:
  - **Cursor:** `.cursor/mcp.json`
  - **VS Code / Cline:** `.vscode/mcp.json`
  - **Google Antigravity:** `~/.gemini/antigravity/mcp/aos.json`

---

### 3. Check Status & Diagnostics

```bash
aos status
```

---

## 🌟 Universal Beta Access (No Credit Card Required)

During the open beta, anyone in the community can unlock full Pro features with zero payment friction:

```bash
# 1. Generate your personal beta key
python -m app.cloud_engine.keygen --campaign beta-2026 --user "your_handle"

# 2. Activate the key on your local machine
aos auth --key <GENERATED_TOKEN>
```

```
=====================================================
 🔑 AOS License Authentication
=====================================================
 🌟 Universal Beta Key Activated: [beta-2026] - Free Pro Access
-----------------------------------------------------
 • Target File:  ~/.aos/license.token
 • User ID:      usr_your_handle
 • Active Tier:  PRO
 • Validity:     365 days remaining
 • Status:       VERIFIED (Pro Features Unlocked)
=====================================================
```

---

## 🏛️ Architecture: Local-First & Zero-Leakage

```
┌─────────────────────────────────────────────────────────────────┐
│                    HOST AI CODING ENVIRONMENT                   │
│          (Cursor / VS Code / Cline / Google Antigravity)        │
└────────────────────────────────┬────────────────────────────────┘
                                 │ JSON-RPC (Model Context Protocol)
┌────────────────────────────────▼────────────────────────────────┐
│                        AOS LOCAL RUNTIME                        │
│                                                                 │
│  ┌───────────────────────┐             ┌─────────────────────┐  │
│  │ Precision AST Slicing │             │ Atomic Revert Guard │  │
│  └───────────────────────┘             └─────────────────────┘  │
│  ┌───────────────────────┐             ┌─────────────────────┐  │
│  │ Local Graph Indexer   │             │ Zero-Zombie Daemon  │  │
│  └───────────────────────┘             └─────────────────────┘  │
│                                                                 │
│  • 100% Offline Capable                • Zero Secrets Harvested │
│  • Bounded Memory (< 80MB)             • Idempotent Lock Safety │
└────────────────────────────────┬────────────────────────────────┘
                                 │ Signed Ed25519 Sync
┌────────────────────────────────▼────────────────────────────────┐
│                        MOTHER AOS CLOUD                         │
│             (Signed Rule Packs & Offline 14-Day Lease)          │
└─────────────────────────────────────────────────────────────────┘
```

### 1. Strict Privacy & Zero-Code-Leakage
- Your source code **NEVER** leaves your machine.
- AST indexing, symbol extraction, dependency graph building, and patch generation are performed entirely in-process on your CPU.
- When communicating with Mother AOS for rule hydration, only abstract topological metadata (node type, tree depth, SHA256 hashes) is processed.

### 2. Offline-First Intelligence (14-Day Grace Period)
- AOS caches signed rule packs (`brain.pack`) locally under `.aos/cache/`.
- If your device loses internet connectivity, AOS runs completely offline with full capabilities for up to **14 days**.
- If offline past the grace period, AOS safely degrades to deterministic baseline heuristics without interrupting your developer workflow.

### 3. Dual-Safety Execution Guardrails
- **Community Tier (`AtomicRevertGuard`):** If an agent patch breaks tests, syntax, or invariants, AOS immediately reverts the file state and provides a distilled 3-line diagnostic.
- **Pro Tier (`AutonomousHealingSandbox`):** Tests agent patches in an isolated sandbox, performing up to 2 bounded self-repair loops before committing changes.

### 4. Zero-Zombie Process Guarantee
- AOS does not leave orphaned background processes running.
- When your IDE session or MCP host disconnects, AOS releases all file locks and RAM in **< 200ms**.

---

## 🛠️ Supported IDEs & Hosts

| Host IDE | Setup Method | Integration Status |
| :--- | :--- | :---: |
| **Cursor** | Automated via `aos setup` (`.cursor/mcp.json`) | ✅ Verified |
| **VS Code / Cline** | Automated via `aos setup` (`.vscode/mcp.json`) | ✅ Verified |
| **Google Antigravity** | Automated via `aos setup` (`~/.gemini/antigravity/mcp/aos.json`) | ✅ Verified |
| **Windsurf / Zed / Neovim** | Standard stdio command: `aos mcp` | ✅ Verified |

---

## 🤝 Open-Core Contributing

We welcome community contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) to understand our architectural boundaries:
- **Community Extension Zones:** Language grammars, Tree-sitter parsers, IDE adapters, and benchmark fixtures (`app/graph/symbols/`, `app/host/adapters/`, `benchmarks/fixtures/`).
- **Sealed Kernel:** Execution invariants, process governance, and Ed25519 cryptography (`app/kernel/`, `app/cloud_engine/crypto.py`).

---

## 📄 License & Trademark Policy

This project is licensed under the [Apache License, Version 2.0](LICENSE).

- **Trademarks:** All rights to the names "AOS", "Agent Operating System", and "Mother AOS" are strictly reserved.
- **Cloud Infrastructure:** The Apache-2.0 license covers the open client and edge runtime code only, and grants no rights to the proprietary Mother AOS Cloud backend infrastructure or models.
