 #!/bin/bash

   URL="http://IP_PUBLICO_DA_INSTANCIA"
   DISCORD_WEBHOOK_URL="URL_DO_SEU_WEBHOOK"
   LOG_FILE="/var/log/meu_script.log"

   touch "$LOG_FILE"

   send_discord_message() {
      MESSAGE="🚨 **ALERTA:** O site $URL está fora do ar!"
      curl -s -o /dev/null -H "Content-Type: application/json" \
            -X POST \
            -d "{\"content\": \"$MESSAGE\"}" \
            "$DISCORD_WEBHOOK_URL"
   }

   # VERIFICA O STATUS DO SITE
   STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")

   if [[ "$STATUS" -ne 200 || "$STATUS" -eq 000 ]]; then
      echo "$(date) - 🚨 SITE FORA DO AR!" >> "$LOG_FILE"
      send_discord_message
   else
      echo "$(date) - ✅ Site funcionando normalmente." >> "$LOG_FILE"
   fi