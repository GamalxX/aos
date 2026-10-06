<div align="center">

# ⚡ AOS — Autonomous AI Operating System
### The Deterministic AI Runtime & Surgical Context Middleware

[![Release](https://img.shields.io/badge/Release-v1.0.3-2563EB.svg?style=for-the-badge)](https://github.com/GamalxX/aos/releases)
[![Tests](https://img.shields.io/badge/Verification-1778%20Passed%20(100%25)-059669.svg?style=for-the-badge)]()
[![AST Slicer](https://img.shields.io/badge/Slicer%20Latency-0.036ms-D97706.svg?style=for-the-badge)]()
[![Security](https://img.shields.io/badge/Zero--Trust-Ed25519%20Keyring-7C3AED.svg?style=for-the-badge)]()
[![Model Dependency](https://img.shields.io/badge/Zero--Ollama-Native%20GGUF-4F46E5.svg?style=for-the-badge)]()

**AOS sits invisibly beneath your IDE and autonomous agents—slashing context consumption by 95%, enforcing cryptographic reality audits on AI actions, and injecting dual-model intelligence into single-model coding environments.**

[The Architecture](#-architectural-manifesto) • [Core Superpowers](#-core-superpowers) • [Dual-LLM Delegate Engine](#-dual-llm-delegate-architecture) • [Security & Zero-Trust](#-zero-trust-security--zero-leak-guarantee) • [Supported Platforms](#-supported-ides--agent-runtimes) • [Quickstart](#-quickstart) • [Pricing](#-pricing--pro-access)

</div>

---

## 🏛️ Architectural Manifesto

Modern AI coding agents suffer from fundamental systemic bottlenecks:
1. **Context Pollution:** Entire multi-thousand-line files are dumped into prompts, wasting millions of tokens, triggering rate limits, and inducing hallucination.
2. **Naive Self-Validation:** Agents routinely claim code works without empirical proof, polluting project memory with broken implementations.
3. **Single-Model Lock-In:** Leading platforms force you into a single active model session, preventing efficient fast-path delegation.
4. **Tool Bloat:** Verbose command outputs (build traces, database dumps, test logs) saturate context windows with noise.

**AOS solves this at the operating-system level.** It is a local, deterministic, MCP-native middleware engine that acts as the sensory and neurological filter between your editor and your language models.

---

## ⚡ Core Superpowers

```
┌────────────────────────────────────────────────────────────────────────┐
│                        DEVELOPER ENVIRONMENT                           │
│     [ OpenAI Codex ]   [ Google Antigravity ]   [ Cursor / Cline ]     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (MCP Protocol / Native Transport)
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                        AOS RUNTIME MIDDLEWARE                          │
│                                                                        │
│  [ System 1 Fast-Path ]          [ Tool Output Gateway ]               │
│  • AST Slicer (0.036ms)          • Head/Tail Trace Extraction          │
│  • Config Resolver (0.47ms)      • Structural Error Pruning            │
│  • 0-Model Token Cost            • 90%+ Output Noise Reduction         │
│                                                                        │
│  [ Deterministic Invariant Store] [ Reality Audit Gate ]               │
│  • Hierarchical v3 Tree          • Exit-Code-0 Assertion Harness       │
│  • Cross-Process Persistence     • Ed25519 Cryptographic Signer        │
│                                                                        │
│  [ Native GGUF Subprocess Engine ]                                     │
│  • In-Process Managed loopback   • embeddinggemma-300M-Q8_0            │
│  • Zero-Ollama Dependency        • Re-entrant RLock Thread Isolation   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ (Verified Triplet Synthesizer)
                                    ▼
                 [ Local 4-bit QLoRA Continuous Learning ]
```

### 1. ✂️ Surgical AST Slicing (95%+ Context Reduction)
- **Single-Pass Deterministic Extraction:** Employs precise AST symbol resolution with regex word boundaries (`\b`) and stem guards.
- **Zero Token Expenditure:** Delivers exact function signatures, dependency trees, and implementation bodies in a median of **0.036 ms** without invoking an external LLM.
- **Fail-Open Resilience:** If dynamic metaprogramming or unsupported ASTs are encountered, AOS instantly falls back to full-file streaming without disrupting developer flow.

### 2. 🧠 Dual-LLM Delegate Architecture (System 1 + System 2)
Most platforms (including Codex and Antigravity) enforce single-session interaction. AOS bridges this gap:
- **System 1 (Ultra-Fast Deterministic Layer):** Handles instantaneous queries, AST extraction, invariant retrieval, and local GGUF embeddings in sub-millisecond cycles with **0 cloud tokens**.
- **System 2 (Deliberative Frontier Reasoning):** Deep architectural planning, cross-file refactoring, and multi-step reasoning are delegated to frontier models fed with surgically compiled context.

### 3. 🔍 Tool Output Gateway (Intelligent Terminal Filtering)
- AI agents easily drown when running commands like `pytest`, `npm test`, or database migrations that return thousands of lines of output.
- The **AOS Gateway** prunes verbosity at wire-speed: isolating stack traces, failure diffs, and relevant log segments, eliminating 90%+ of wasted terminal tokens.

### 4. 🔐 Zero-Trust Reality Audit (Ed25519 Keyring)
- Rejects unverified agent assertions. No patch or memory state is admitted into project memory without an exit-code-0 receipt from an isolated execution harness.
- Each receipt is hashed and cryptographically signed via an **owner-only Ed25519 private key** (`~/.aos/security/reality_audit_ed25519.key`), surviving IDE reboots and preventing memory poisoning.

### 5. 🧬 Autonomous Continuous Learning (QLoRA Pipeline)
- Collects verified task triplets: `(prompt, surgical_ast_context, accepted_patch_diff)`.
- Automatically strips credentials, API tokens, and secret patterns via built-in redaction filters.
- Persists sanitized datasets under `.aos/training/qlora_dataset.jsonl` ready for local 4-bit NF4 adapter fine-tuning.

### 6. 🚀 Zero-Dependency Local Embedding Runner
- **No External Daemons:** Operates a native, windowless local loopback subprocess running `llama-server.exe` with quantized Gemma weights (`embeddinggemma-300M-Q8_0.gguf`).
- Fully isolated with `threading.RLock` to eliminate concurrency deadlocks.

---

## 🔌 Supported IDEs & Agent Runtimes

AOS connects seamlessly via standard Model Context Protocol (MCP) transports or background daemons:

| Platform / Tool | Integration Tier | Execution Capabilities |
| :--- | :---: | :--- |
| **OpenAI Codex** | **Native / First-Class** | MCP Middleware, Surgical AST, Dual-Model Fast-Path |
| **Google Antigravity**| **Native / First-Class** | Tool Gateway, Deterministic Context, Reality Audit |
| **Cursor IDE** | **Native / First-Class** | In-Process MCP Server (`aos mcp`), 0-Token Config Lookup |
| **Cline (VS Code)** | **Native / First-Class** | Native Extension MCP Provider with Zero Window Popups |
| **Claude Code** | **Native / First-Class** | High-performance stdio IPC stream |
| **Windsurf & VS Code**| **Native / First-Class** | Background Daemon with Multi-Host Shared Broker |

---

## 📊 Measured Benchmark Proof

Empirically validated across **1,778 passing unit & integration tests**:

| Subsystem | Benchmark Metric | Measured Performance | Operational Result |
| :--- | :---: | :---: | :--- |
| **AST Symbol Slicer** | Execution Latency | **0.036 ms (Median)** | **95.68% Context Reduction** |
| **Config Fast-Path** | Resolution Latency | **0.477 ms (Median)** | **0 Model Calls / 0 Tokens** |
| **Security Sandbox** | Symlink Traversal | **100% Blocked** | Enforced via `is_relative_to` |
| **Lock Governor** | Concurrency Race | **0 Collisions** | OS handle retention (Zero-Unlink) |
| **Asset Bootstrapper** | Integrity Validation | **SHA-256 Verified** | Resumable chunked downloads |

---

## 🛠️ Quickstart

### 1. Run Built-In System Health Diagnostic
Verify your local runtime environment with a single command:
```powershell
aos doctor
```

```json
{
  "ready": true,
  "checks": {
    "kernel_lock_governor": { "ready": true, "status": "operational" },
    "ed25519_audit_keypair": { "ready": true, "status": "active" },
    "local_embedding_assets": { "ready": true, "status": "verified" },
    "ast_slicer_config_resolver": { "ready": true, "median_ms": 0.036 },
    "project_knowledge_store": { "ready": true, "status": "hierarchical_v3_operational" }
  }
}
```

### 2. Auto-Bootstrap Local Model Weights

```powershell
aos setup-assets
```

*Automatically downloads and verifies the quantized Gemma 300M embedding weights and the high-speed local runner.*

### 3. Connect to Your Preferred Environment

Add AOS to your IDE's MCP settings (e.g., `cursor_settings.json` or `claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "aos": {
      "command": "aos",
      "args": ["mcp"]
    }
  }
}
```

---

## 💎 Pricing & Pro Access

* **Community Core (100% Free Forever):**
  * Complete Local Kernel v1.0.3.
  * Sub-millisecond AST Slicer & 0-Model Config Fast-Paths.
  * Standalone Gemma Embedding Runner (Zero-Ollama).
  * Unlimited local repository memory and invariant storage.

* **AOS Pro (7-Day Full Access Free Trial):**
  * **Free 7-Day Trial:** Test full federated capabilities without upfront commitments.
  * Multi-Repository Invariant Synchronization.
  * Automated 4-bit QLoRA Continuous Learning Pipeline.
  * Cloud Engine Telemetry Registry and Team Knowledge Hub.

---

## 🛡️ Zero-Trust Security & Zero-Leak Guarantee

* **Zero Source Code Transmission:** Your proprietary source code never leaves your local workspace.
* **Secret Redaction:** Tokens, `.env` files, and credentials are cryptographically redacted before reaching dataset export or context pipelines.
* **Windowless Concurrency on Windows:** Managed background execution without flashing terminal windows (`CREATE_NO_WINDOW`).
* **Crash Isolation:** If a background process experiences an anomaly, the host IDE remains 100% stable.
