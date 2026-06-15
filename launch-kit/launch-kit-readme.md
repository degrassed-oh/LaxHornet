# LaxHornet Launch Kit

Public app link:

https://degrasse-mastermind.github.io/LaxHornet/

## Files

- `laxhornet-qr.png`: QR code for the public app link.
- `parent-handout.html`: Printable one-page parent handout.
- `invite-message.txt`: Email or team-app message.
- `short-text-message.txt`: Short SMS/iMessage version.

## How To Use

1. Open `parent-handout.html` in a browser.
2. Print it, or use the browser's Print command and choose Save as PDF.
3. Share the QR code image in team chats, emails, or printed material.
4. Send `invite-message.txt` to parents and coaches.

## Important Launch Settings

In Supabase, the app's Site URL should be:

https://degrasse-mastermind.github.io/LaxHornet/

Redirect URLs should include:

https://degrasse-mastermind.github.io/LaxHornet/
https://degrasse-mastermind.github.io/LaxHornet/?auth=verified

Run the latest `supabase-schema.sql` before inviting a lot of users so multi-player cloud sync includes the `player_id` field.
