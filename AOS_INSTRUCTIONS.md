# AOS Agent Companion Guide (AI Host Instructions)

Welcome to the **AOS (Agent Operating System)** runtime.
You are operating within an AOS-accelerated development environment. AOS acts as a sub-LLM intelligence plane, deterministic code intelligence layer, and zero-waste token compressor for host AI coding models.

---

## ⚡ Core Operational Directives

### 1. Mandatory Pre-Execution Call (`aos_prepare_task`)
Whenever the user requests:
- Modifying, refactoring, or writing code
- Inspecting configuration, constants, or architecture
- Fixing a bug or running test diagnostics

**You MUST FIRST call the `aos` MCP tool with `action="prepare_task"`:**
```json
{
  "name": "aos",
  "arguments": {
    "action": "prepare_task",
    "task_description": "Precise description of the user request"
  }
}
```

### 2. Utilize Returned Precision Slices
AOS will analyze the AST and repository graph and return:
- `precision_slices`: Exact target functions and dependencies (input tokens < 350 vs full files).
- `extracted_invariants`: Mandatory test rules and constraints that must not be broken.
- `strategy`: The execution route (`TIER_0_ZERO_MODEL_AST`, `PRECISION_SLICING`, or `DELEGATE`).
- `client_summary`: Bilingual empirical token savings string.

**Do NOT read entire 5,000-line source files into context** when `precision_slices` are provided. Edit strictly within the bounded precision slices.

### 3. Verification & Guardrails
- **Community Tier (`AtomicRevertGuard`):** If your edit breaks tests or invariants, AOS will automatically roll back the file to its original state and provide a 3-line distilled report.
- **Pro Tier (`AutonomousHealingSandbox`):** AOS tests your patch in a sandboxed directory and executes up to 2 bounded self-repair attempts using precision slices before committing to the main tree.

### 4. Bilingual Client Summary Display
Always append the `client_summary_en` or `client_summary_ar` to your final response to inform the user of the concrete token and cost savings achieved:
> ⚡ **[AOS Value]:** Saved 94.2% tokens (3,850 tokens) in 2.10ms via Precision Context Slicing.

---

## 🛡️ Terms of Service & Security Invariants
1. **Zero Session Scraping:** AOS operates strictly through official host MCP tools or developer API keys.
2. **Zero Zombie Daemons:** When your IDE session closes, AOS releases all locks and memory within < 200ms.
3. **Repository Scoping:** All project indices and memory live in `.aos/` which is automatically added to `.gitignore`.
