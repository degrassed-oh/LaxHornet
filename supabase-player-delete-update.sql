-- LaxHornet v118: parent tracker player removal helper.
-- Run this in Supabase Dashboard > SQL Editor.

create or replace function public.laxhornet_delete_player_claim(
  p_team_id text,
  p_roster_player_id text
)
returns void
language plpgsql
security definer
set search_path = public
as $laxhornet_delete_player_claim$
declare
  deleted_count integer;
begin
  if (select auth.uid()) is null then
    raise exception 'Sign in required';
  end if;

  delete from public.player_claims
  where player_claims.team_id = p_team_id
    and player_claims.roster_player_id = p_roster_player_id
    and (
      player_claims.user_id = (select auth.uid())
      or (select public.laxhornet_is_platform_reviewer())
      or (select public.laxhornet_team_role(p_team_id)) = 'admin'
    );

  get diagnostics deleted_count = row_count;
  if deleted_count = 0 then
    raise exception 'Player access not found';
  end if;
end;
$laxhornet_delete_player_claim$;

grant execute on function public.laxhornet_delete_player_claim(text, text) to authenticated;
