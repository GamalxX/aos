# Contributing to AOS (Agent Operating System)

Thank you for your interest in contributing to **AOS**! We are building the next-generation autonomous runtime that connects developer tools, AI coding agents, and language models with deterministic precision, zero-leakage privacy, and sub-second execution.

This document outlines the **Open-Core Architecture Boundary**, our contribution guidelines, and how to get started developing locally.

---

## 🏛️ Architectural Boundary: Open-Core vs. Sealed Kernel

AOS follows a disciplined Open-Core model designed to maximize community extensibility while preserving deterministic execution invariants, security guarantees, and cryptographic integrity.

```
┌──────────────────────────────────────────────────────────────┐
│                    COMMUNITY EXTENSION ZONES                 │
│  (Open for Community Contributions & Plugins via PRs)        │
│  • AST Extractors & Language Parsers  [app/graph/symbols/]   │
│  • Host IDE Adapters & Hooks          [app/host/adapters/]   │
│  • Benchmark Fixtures & Evaluations   [benchmarks/fixtures/] │
│  • Client CLI Tools & Workflows       [app/client/]          │
└──────────────────────────────┬───────────────────────────────┘
                               │ Structured Contracts
┌──────────────────────────────▼───────────────────────────────┐
│                      SEALED KERNEL CORE                      │
│  (Protected Invariants — Requires Core Maintainer RFC)       │
│  • TaskContract & Delegation Arbiter  [app/kernel/delegation]│
│  • Ed25519 Cryptography & Tokens      [app/cloud_engine/crypto]
│  • Atomic Revert & Memory Governor   [app/client/lifecycle] │
│  • Pricing & Dynamic Economics Engine [app/kernel/pricing]   │
└──────────────────────────────────────────────────────────────┘
```

### 1. 🟢 Community Extension Zones (Fast-Track PRs)

We warmly encourage community contributions in the following areas:

1. **AST Symbol Extractors & Language Parsers (`app/graph/symbols/`):**
   - Adding Tree-sitter parsers and symbol resolvers for additional programming languages (e.g., Rust, Go, Zig, C++, Kotlin, Swift).
   - Enhancing type-inference heuristics and call-graph linkers.
2. **Host IDE Adapters & Hooks (`app/host/adapters/`, `app/product_runtime/`):**
   - Integrations for new IDEs, editors, or agent harnesses (e.g., Cursor, Antigravity, VS Code / Cline, Windsurf, Zed, Neovim).
   - MCP protocol extensions and tool schema enhancements.
3. **Benchmark Fixtures & Real-World Regression Suites (`benchmarks/`):**
   - High-fidelity real-world code refactoring scenarios.
   - Cross-language benchmark fixtures in TypeScript, C#, Python, and more.
4. **Documentation, Examples, & Client CLI UX (`docs/`, `distribution/`, `app/client/cli_setup.py`):**
   - Improving developer experience, installer scripts, and guides.

### 2. 🔒 Sealed Kernel Core (Requires Architectural RFC)

The following modules maintain strict invariant guarantees:
- **`app/kernel/delegation/task_contract.py` & `adversarial_arbiter.py`:** Sandboxed delegation safety and non-destructive execution contracts.
- **`app/cloud_engine/crypto.py` & `keygen.py`:** Ed25519 asymmetric cryptography, token generation, and signature verification.
- **`app/client/lifecycle.py` (`ProcessGovernor`):** Zero-zombie process guarantees, singleton locks, and idle RAM eviction.
- **`app/kernel/pricing_engine.py`:** Dynamic token pricing calculations and cost accounting.

> **Note:** Changes to the Sealed Kernel require an accepted RFC (Request for Comments) issue before code PRs will be merged.

---

## 🛠️ Local Development Setup

### Prerequisites
- Python 3.10+ (Python 3.11 recommended)
- Git
- Virtual environment (`venv` or `uv`)

### 1. Clone & Set Up Virtual Environment

```bash
git clone https://github.com/agent-operating-system/aos.git
cd aos

# Create virtual environment
python -m venv .venv

# Activate virtual environment
# Windows:
.venv\Scripts\activate
# Linux / macOS:
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt
pip install pytest pytest-asyncio fastapi uvicorn cryptography pydantic
```

### 2. Verify Your Environment

Run the full test suite to verify your baseline setup:

```bash
python -m pytest tests/ -v
```

All tests should pass.

---

## 🧪 Testing Guidelines

- **Zero-Mock Policy for Core Logic:** Tests must execute real AST parsing, real cryptographic signing/verification, and real contract enforcement.
- **Isolated State:** Tests that write state must use temporary directories or scoped `.aos/` roots. Do not pollute the repository root.
- **Fast Execution:** Unit test suites should complete in seconds.

To run specific test modules:
```bash
# Business architecture and license verification
python -m pytest tests/test_business_architecture.py -v

# Core production architecture & ProcessGovernor
python -m pytest tests/test_production_architecture.py -v

# Adversarial delegation & host sampling
python -m pytest tests/test_adversarial_delegation_and_sampling.py -v
```

---

## 🚀 Submitting a Pull Request

1. **Branch Naming:**
   - `feature/add-rust-symbol-extractor`
   - `fix/cursor-mcp-path-resolution`
   - `benchmark/add-go-concurrency-fixture`
2. **Commit Messages:**
   - Follow standard Conventional Commits: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`.
3. **PR Checklist:**
   - [ ] My code adheres to the Open-Core architectural boundary.
   - [ ] New code is covered by tests in `tests/`.
   - [ ] All tests pass cleanly (`pytest`).
   - [ ] Documentation and docstrings are updated.
   - [ ] No temporary files, binaries, or `.aos/` directories are committed.

---

## 🌟 Universal Beta Access

Contributors and community members can access all Pro features during the universal open beta without payment or credit card registration:

```bash
# Generate your personal beta key
python -m app.cloud_engine.keygen --campaign beta-2026 --user "usr_yourname"

# Activate the key locally
aos auth --key <GENERATED_TOKEN>
```

Thank you for helping build the future of autonomous agent software engineering!
