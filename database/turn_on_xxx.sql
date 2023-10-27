--
-- turn_on_xxx.sql - turn on XXX buttons and cells
--
UPDATE action_button
SET action_button_enabled_tf = 'T'
WHERE LOWER(action_button_label) LIKE '%xxx%';
--
UPDATE page_layout_cell
SET cell_display_tf = 'T'
WHERE LOWER( cell_label ) LIKE '%xxx%';
--
-- COMMIT must be executed separately
--
-- done
--
