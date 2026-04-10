CREATE TABLE IF NOT EXISTS dishes (
  id TEXT PRIMARY KEY,
  name_zh TEXT NOT NULL,
  rating_score REAL NOT NULL,
  rating_label TEXT NOT NULL,
  short_recipe TEXT NOT NULL,
  category TEXT NOT NULL,
  audience TEXT NOT NULL DEFAULT 'adult',
  display_order INTEGER NOT NULL DEFAULT 0,
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_dishes_audience_active_order
ON dishes (audience, is_active, display_order);
