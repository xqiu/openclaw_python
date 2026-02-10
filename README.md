# openclaw_python

## setup
```
docker compose --profile cli run --rm openclaw-cli onboard
```

◇  I understand this is powerful and inherently risky. Continue?
=>  Yes

◇  Onboarding mode
=>  Manual

◇  What do you want to set up?
=>  Local gateway (this machine)

◇  Workspace directory
=>  /home/node/.openclaw/workspace

◇  Model/auth provider
=>  Copilot

◇  Copilot auth method
=>  GitHub Copilot (GitHub device login)
visit https://github.com/login/device
paste code it provide

◇  Default model
=>  github-copilot/gpt-5.2

◇  Gateway port
=>  18789

◇  Gateway bind
=>  LAN (0.0.0.0)

◇  Gateway auth
=>  Token

◇  Tailscale exposure
=>  Off

◇  Gateway token (blank to generate)
=>  <your token>

◇  Configure chat channels now?
=>  Yes

◇  Configure skills now? (recommended)
=>  Yes

◇  Show Homebrew install command?
=>  No

◇  Preferred node manager for skill installs
=>  npm

◇  Install missing skill dependencies
=>  🐙 github

◇  Set GOOGLE_PLACES_API_KEY for goplaces?
=>  No

◇  Set GOOGLE_PLACES_API_KEY for local-places?
=>  No

◇  Set GEMINI_API_KEY for nano-banana-pro?
=>  No

◇  Set NOTION_API_KEY for notion?
=>  No

◇  Set OPENAI_API_KEY for openai-image-gen?
=>  No

◇  Set OPENAI_API_KEY for openai-whisper-api?
=>  No

◇  Set ELEVENLABS_API_KEY for sag?
=>  No

◇  Enable hooks?
=> select all  🚀 boot-md, 📝 command-logger, 💾 session-memory

│  You can manage hooks later with:
│    openclaw hooks list
│    openclaw hooks enable <name>
│    openclaw hooks disable <name>

http://localhost:18789/?token=<token>

## skill

### Locations and precedence
Skills are loaded from three places:
- Bundled skills: shipped with the install (npm package or OpenClaw.app)
- Managed/local skills: ~/.openclaw/skills
- Workspace skills: <workspace>/skills

If a skill name conflicts, precedence is:

1. <workspace>/skills
2. ~/.openclaw/skills
3. bundled skills (lowest)
4. directory in skills.load.extraDirs in ~/.openclaw/openclaw.json.

### Per-agent vs shared skills
In multi-agent setups, each agent has its own workspace. That means:
- Per-agent skills live in <workspace>/skills for that agent only.
- Shared skills live in ~/.openclaw/skills (managed/local) and are visible to all agents on the same machine.
- Shared folders can also be added via skills.load.extraDirs (lowest precedence) if you want a common skills pack used by multiple agents.

If the same skill name exists in more than one place, the usual precedence applies: workspace wins, then managed/local, then bundled.