-- Kjør i Supabase → SQL Editor
create table if not exists public.progress (
  username   text primary key check (username ~ '^[a-z0-9]{2,20}$'),
  mastered   int  not null default 0,
  total      int  not null default 0,
  best_exam  int  not null default 0,
  exams      int  not null default 0,
  streak     int  not null default 0,
  state      jsonb,
  updated_at timestamptz not null default now()
);

alter table public.progress enable row level security;

-- Alle kan lese leaderboardet og lagre fremgang (ingen passord, bare brukernavn)
create policy "les"     on public.progress for select using (true);
create policy "sett_inn" on public.progress for insert with check (true);
create policy "oppdater" on public.progress for update using (true) with check (true);
