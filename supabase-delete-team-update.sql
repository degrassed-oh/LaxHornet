-- LaxHornet v117: admin team deletion helper.
-- Run this in Supabase Dashboard > SQL Editor.

create or replace function public.laxhornet_delete_team(
  p_team_id text
)
returns void
language plpgsql
security definer
set search_path = public
as $laxhornet_delete_team$
declare
  deleted_count integer;
begin
  if (select auth.uid()) is null then
    raise exception 'Sign in required';
  end if;

  if not (
    (select public.laxhornet_is_platform_reviewer())
    or (select public.laxhornet_team_role(p_team_id)) = 'admin'
  ) then
    raise exception 'Team admin access required';
  end if;

  delete from public.teams
  where teams.id = p_team_id;

  get diagnostics deleted_count = row_count;
  if deleted_count = 0 then
    raise exception 'Team not found';
  end if;
end;
$laxhornet_delete_team$;

grant execute on function public.laxhornet_delete_team(text) to authenticated;
