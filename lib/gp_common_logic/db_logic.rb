module GpCommonLogic

  module DB_Logic

    GET_USER_SEGMENT_IDS_FUNCTION = <<~SQL
      CREATE OR REPLACE FUNCTION public.get_user_segment_ids(age integer, clothing_size integer) RETURNS integer[]
      LANGUAGE sql
      AS $$
        SELECT CASE
        WHEN clothing_size <= 50 THEN
          CASE
          WHEN age <= 44 THEN array[4450, 4400, 50, 0]
          WHEN age >  44 THEN array[4550, 4500, 50, 0]
                         ELSE array[            50, 0]
          END
        WHEN clothing_size >= 52 THEN
          CASE
          WHEN age <= 44 THEN array[4452, 4400, 52, 0]
          WHEN age >  44 THEN array[4552, 4500, 52, 0]
                         ELSE array[            52, 0]
          END
        ELSE
          CASE
          WHEN age <= 44 THEN array[4400, 0]
          WHEN age > 44  THEN array[4500, 0]
                         ELSE array[      0]
          END
        END;
      $$;
    SQL

    GET_USER_SEGMENT_ID_FUNCTION = <<~SQL
      CREATE OR REPLACE FUNCTION public.get_user_segment_id(age integer, clothing_size integer) RETURNS integer
      LANGUAGE sql
      AS $$
        SELECT MAX(s) FROM unnest(get_user_segment_ids(age, clothing_size)) s;
      $$;
    SQL

  end

end
