DO
$$
    DECLARE

        local_name_table       TEXT;
        local_name_sequence    TEXT;
        local_name_column      TEXT;
        local_schema_name      TEXT;
        local_current_sequence INT;

    BEGIN


        FOR local_name_sequence, local_name_table, local_name_column, local_schema_name IN (SELECT seq.relname AS sequence_name,
                                                                                                   tab.relname AS table_name,
                                                                                                   col.attname AS column_name,
                                                                                                   ns.nspname  AS schema_name
                                                                                            FROM pg_class AS seq
                                                                                                     JOIN pg_depend AS dep ON seq.relfilenode = dep.objid
                                                                                                     JOIN pg_class AS tab ON dep.refobjid = tab.relfilenode
                                                                                                     JOIN pg_namespace AS ns ON seq.relnamespace = ns.oid
                                                                                                     JOIN pg_attribute AS col
                                                                                                          ON col.attrelid = tab.relfilenode AND col.attnum = dep.refobjsubid
                                                                                            WHERE seq.relkind = 'S')
            LOOP


                EXECUTE CONCAT('(SELECT ', 'MAX(', local_name_column, ')  FROM ', local_schema_name, '.',
                               local_name_table, ');')
                    INTO local_current_sequence;

                IF local_current_sequence IS NOT NULL THEN
                    EXECUTE CONCAT('ALTER SEQUENCE ', local_name_sequence, ' RESTART WITH ',
                                   (local_current_sequence) + 1, ';');

                END IF;

            END LOOP;

        RAISE NOTICE 'Secuencias actualizadas.';
    END;
$$
