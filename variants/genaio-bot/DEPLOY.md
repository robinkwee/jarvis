# GeniBot — OpenClaw Agent Deployment

**Deploy GeniBot as a native OpenClaw agent on your VPS.**

Since OpenClaw is already running, leverage it directly instead of building separate infrastructure.

---

## Setup (5 minutes)

### 1. Get Your Telegram ID

Message @userinfobot in Telegram to get your ID and your partner's ID.

```
Your ID: 123456789
Partner ID: 987654321
```

### 2. Update `.env.telegram`

```bash
cd /home/robin/jarvis/variants/genaio-bot
nano .env.telegram
```

Fill in:
```env
TELEGRAM_BOT_TOKEN=8606382447:AAEi655G6eOtl5164O4bB_Q7uE1Uop4mihA
TELEGRAM_WEBHOOK_URL=https://your-vps-domain.com/agents/genaio-bot/telegram
ADMIN_TELEGRAM_ID=123456789
PARTNER_TELEGRAM_ID=987654321
GENAIO_BRAIN_PATH=/home/robin/jarvis/variants/genaio-bot/brain
```

### 3. Register Agent with OpenClaw

Load the agent into OpenClaw's registry:

```bash
openclaw agent register \
  --name genaio-bot \
  --config genibot.agent \
  --env-file .env.telegram \
  --brain-path $GENAIO_BRAIN_PATH
```

Or manually copy the config to OpenClaw's agent directory:

```bash
cp genibot.agent /home/robin/.openclaw/agents/genaio-bot.agent
cp .env.telegram /home/robin/.openclaw/agents/genaio-bot.env
```

### 4. Register Telegram Webhook

Tell Telegram where to send messages:

```bash
curl -X POST \
  https://api.telegram.org/bot8606382447:AAEi655G6eOtl5164O4bB_Q7uE1Uop4mihA/setWebhook \
  -H "Content-Type: application/json" \
  -d "{\"url\": \"https://your-vps-domain.com/agents/genaio-bot/telegram\"}"
```

Response should be:
```json
{"ok":true,"result":true,"description":"Webhook was set"}
```

### 5. Test

Message GeniBot on Telegram:

```
You: "What's our current roadmap?"

GeniBot: 
  [reads brain docs via OpenClaw]
  
  "Based on your GENAIO brain, here's the roadmap:
  
  Q2 2026: Feature X, user research
  Q3 2026: Feature Y, launch prep
  
  Next step: Update with latest design decisions."
```

---

## How It Works

```
Telegram Message
     ↓
Telegram API
     ↓
OpenClaw Webhook Handler (already running on VPS)
     ↓
GeniBot Agent (Claude session)
     ├── Reads brain docs
     ├── Reasons with Claude
     └── Generates response
     ↓
Telegram API
     ↓
Your Phone
```

**No separate infrastructure needed.** OpenClaw handles everything.

---

## Architecture

On your VPS (8GB):

```
Port 18789  → OpenClaw Gateway (running)
  └── /agents/genaio-bot/telegram → GeniBot Agent
      ├── Claude Opus 4.8 reasoning
      ├── Brain search (GENAIO docs)
      └── Conversation memory
      
Port 8000   → Personal Jarvis (optional)
Port 8003   → (not needed anymore)
```

Memory efficient: agents share resources via OpenClaw.

---

## Admin Commands

Once deployed, you can manage GeniBot via OpenClaw:

```bash
# Check agent status
openclaw agent status genaio-bot

# View logs
openclaw agent logs genaio-bot -f

# Restart agent
openclaw agent restart genaio-bot

# Update configuration
openclaw agent update genaio-bot --config genibot.agent
```

---

## Troubleshooting

### "Webhook not responding"

```bash
# Check webhook is registered
curl https://api.telegram.org/bot{TOKEN}/getWebhookInfo
```

Should return:
```json
{"ok":true,"result":{"url":"https://your-vps-domain.com/agents/genaio-bot/telegram",...}}
```

### "Agent not responding"

```bash
# Check agent is registered
openclaw agent list | grep genaio-bot

# Check logs
openclaw agent logs genaio-bot
```

### "Permission denied to read brain"

Ensure brain path is readable:
```bash
chmod -R 755 /home/robin/jarvis/variants/genaio-bot/brain
```

---

## What's Running Now

✅ OpenClaw gateway (port 18789)  
✅ GeniBot agent (registered with OpenClaw)  
✅ Telegram webhook (connected)  
✅ Claude Opus (reasoning engine)  
✅ Brain indexing (GENAIO docs searchable)  

**Everything is already here. Just wire it up.** 🚀
