--
-- turn_off_xxx.sql - turn off XXX buttons and cells
--
UPDATE action_button
SET action_button_enabled_tf = 'F'
WHERE LOWER(action_button_label) LIKE '%xxx%';
--
UPDATE page_layout_cell
SET cell_display_tf = 'F'
WHERE LOWER( cell_label ) LIKE '%xxx%';
--
-- COMMIT must be executed separately
--
-- done
--
