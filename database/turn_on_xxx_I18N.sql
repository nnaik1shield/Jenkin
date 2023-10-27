--
-- turn_off_xxx.sql - turn off XXX buttons and cells
--- new ----
UPDATE action_button
SET action_button_enabled_tf = 'T'
where action_button_id in  
(select a.action_button_id from action_button a, translation_key b
where a.action_button_label = b.translation_key_id 
and LOWER (original_text )LIKE '%xxx%'
);

commit;

--- new ----
UPDATE page_layout_cell
SET cell_display_tf = 'T'
WHERE page_layout_cell_id in 
(select page_layout_cell_id from  page_layout_cell a, translation_label b
where a.cell_label = b.translation_key_id 
and LOWER (translation_value )LIKE '%xxx%'
);

commit;


--
-- COMMIT must be executed separately
--
-- done
--


