-- LaxHornet Supabase schema
-- Run this in Supabase Dashboard > SQL Editor before using Live Share.

create table if not exists public.games (
  id text primary key,
  share_code text not null unique,
  opponent text not null,
  game_date date not null,
  location text,
  game_type text,
  player_snapshot jsonb not null default '{}'::jsonb,
  current_quarter text not null default 'Q1',
  status text not null default 'in-progress',
  created_at timestamptz not null default now(),
  saved_at timestamptz,
  ended_at timestamptz
);

create table if not exists public.events (
  id text primary key,
  game_id text not null references public.games(id) on delete cascade,
  timestamp timestamptz not null,
  quarter text not null,
  stat_type text not null,
  stat_label text not null,
  category text not null,
  point_value integer not null default 0,
  tags text[] not null default '{}'::text[],
  note text not null default '',
  field_zone text not null default '',
  corrected_at timestamptz,
  tags_updated_at timestamptz,
  created_at timestamptz not null default now()
);

create index if not exists games_share_code_idx on public.games (share_code);
create index if not exists events_game_id_timestamp_idx on public.events (game_id, timestamp);

grant select, insert, update, delete on public.games to anon;
grant select, insert, update, delete on public.events to anon;

alter table public.games enable row level security;
alter table public.events enable row level security;

drop policy if exists "laxhornet public read games" on public.games;
drop policy if exists "laxhornet public insert games" on public.games;
drop policy if exists "laxhornet public update games" on public.games;
drop policy if exists "laxhornet public delete games" on public.games;
drop policy if exists "laxhornet public read events" on public.events;
drop policy if exists "laxhornet public insert events" on public.events;
drop policy if exists "laxhornet public update events" on public.events;
drop policy if exists "laxhornet public delete events" on public.events;

create policy "laxhornet public read games"
on public.games for select
to anon
using (true);

create policy "laxhornet public insert games"
on public.games for insert
to anon
with check (true);

create policy "laxhornet public update games"
on public.games for update
to anon
using (true)
with check (true);

create policy "laxhornet public delete games"
on public.games for delete
to anon
using (true);

create policy "laxhornet public read events"
on public.events for select
to anon
using (true);

create policy "laxhornet public insert events"
on public.events for insert
to anon
with check (true);

create policy "laxhornet public update events"
on public.events for update
to anon
using (true)
with check (true);

create policy "laxhornet public delete events"
on public.events for delete
to anon
using (true);

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'games'
  ) then
    alter publication supabase_realtime add table public.games;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'events'
  ) then
    alter publication supabase_realtime add table public.events;
  end if;
end $$;
