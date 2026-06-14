# LaxHornet

LaxHornet is a mobile-first offline PWA for tracking youth lacrosse stats during games. It uses plain HTML, CSS, and JavaScript. Player settings, active games, and saved games are stored in `localStorage`, with optional Supabase Live Share for real-time viewing on another device.

## Features

- Home, Player Settings, Start New Game, Live Game Tracker, Game Review, Past Games, and Season Dashboard screens
- Big one-handed live stat buttons for game-day use
- Quarter selector for Q1, Q2, Q3, Q4, and OT
- Undo last event, save game, end game, review, and delete game actions
- Game Impact Score calculated from each event
- Season totals and averages from saved games
- Offline-ready `manifest.json` and service worker
- Optional Supabase Live Share with a share code/link for read-only real-time viewing

## Local Setup

No install step is required.

```bash
python -m http.server 5173
```

Then open:

```text
http://localhost:5173
```

You can also use any static file server. Serving over `http://localhost` is recommended so the service worker can register during testing.

## GitHub Pages Deployment

1. Push this repository to GitHub.
2. In the GitHub repository, open **Settings**.
3. Go to **Pages**.
4. Under **Build and deployment**, choose **Deploy from a branch**.
5. Select your branch, usually `main`, and the root folder `/`.
6. Save. GitHub Pages will publish the static PWA.

The app uses relative paths (`./`) so it can run from a GitHub Pages project URL such as:

```text
https://your-username.github.io/LaxHornet/
```

## Supabase Live Share Setup

The app is configured for:

```text
https://ulbmjcvnyznvmjgpstno.supabase.co
```

To create the database tables:

1. Open the Supabase project dashboard.
2. Go to **SQL Editor**.
3. Open `supabase-schema.sql` from this repo.
4. Paste the full SQL into Supabase and run it.
5. Start a new game in LaxHornet.
6. Use the **Live Share** code or **Copy Share Link** button from the Live Game Tracker.

The first schema uses public read/write policies so a no-login static GitHub Pages app can sync from iPhones. Use this only for stats you are comfortable sharing. A more secure owner/viewer-token or Supabase Auth setup can be added later.

## Stat Scoring

- Goal: +5
- Assist: +4
- Shot on Goal: +2
- Shot: +1
- Ground Ball: +3
- Caused Turnover: +3
- Defensive Stop: +3
- Successful Clear: +2
- Hustle Play: +1
- Smart Play: +1
- Turnover: -2
- Failed Clear: -2
- Penalty: -2
- Note: 0

For dashboard percentages, `Shot on Goal` counts as both a shot and a shot on goal. The `Shot` button is best used for shots that are not on goal.
