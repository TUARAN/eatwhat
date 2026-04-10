export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === "/api/dishes") {
      return handleDishesRequest(url, env);
    }

    return env.ASSETS.fetch(request);
  }
};

async function handleDishesRequest(url, env) {
  const audience = url.searchParams.get("audience") || "adult";

  const { results } = await env.DB.prepare(
    `SELECT
      id,
      name_zh,
      rating_score,
      rating_label,
      short_recipe,
      category,
      audience,
      display_order
    FROM dishes
    WHERE is_active = 1 AND audience = ?
    ORDER BY display_order ASC, name_zh ASC`
  )
    .bind(audience)
    .all();

  return Response.json({
    audience,
    count: results.length,
    dishes: results
  });
}
