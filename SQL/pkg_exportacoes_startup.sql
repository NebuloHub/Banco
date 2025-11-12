--------------------------------------------------------------------------------
--                                  spec
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pkg_exportacoes_startup AS
  PROCEDURE prc_exportar_todas_startups_json(p_json OUT CLOB);
END pkg_exportacoes_startup;



--------------------------------------------------------------------------------
--                                  Body
--------------------------------------------------------------------------------


CREATE OR REPLACE PACKAGE BODY pkg_exportacoes_startup AS

  PROCEDURE prc_exportar_todas_startups_json(p_json OUT CLOB) IS
    v_json        CLOB := '[';
    v_first_startup BOOLEAN := TRUE;
    v_first_item  BOOLEAN;
  BEGIN
    FOR r_startup IN (
      SELECT s.*
      FROM startup s
      ORDER BY s.nome_startup
    ) LOOP
      IF NOT v_first_startup THEN
        v_json := v_json || ',';
      ELSE
        v_first_startup := FALSE;
      END IF;

      v_json := v_json || '{' ||
        '"cnpj":"' || r_startup.cnpj || '",' ||
        '"video":"' || NVL(r_startup.video, '') || '",' ||
        '"nome_startup":"' || REPLACE(r_startup.nome_startup,'"','\"') || '",' ||
        '"site":"' || NVL(r_startup.site, '') || '",' ||
        '"descricao":"' || REPLACE(DBMS_LOB.SUBSTR(r_startup.descricao,4000,1),'"','\"') || '",' ||
        '"nome_responsavel":"' || NVL(r_startup.nome_responsavel, '') || '",' ||
        '"email_startup":"' || r_startup.email_startup || '",' ||
        '"cpf":"' || NVL(r_startup.cpf, '') || '",';

      ------------------------------------------------------------------
      -- HABILIDADES (subarray)
      ------------------------------------------------------------------
      v_json := v_json || '"habilidades":[';
      v_first_item := TRUE;

      FOR r_hab IN (
        SELECT h.id_habilidade, h.nome_habilidade, h.tipo_habilidade
        FROM possui p
        JOIN habilidade h ON p.id_habilidade = h.id_habilidade
        WHERE p.cnpj = r_startup.cnpj
      ) LOOP
        IF NOT v_first_item THEN
          v_json := v_json || ',';
        ELSE
          v_first_item := FALSE;
        END IF;

        v_json := v_json || '{' ||
          '"id":' || r_hab.id_habilidade || ',' ||
          '"nome":"' || REPLACE(r_hab.nome_habilidade,'"','\"') || '",' ||
          '"tipo":"' || REPLACE(r_hab.tipo_habilidade,'"','\"') || '"' ||
        '}';
      END LOOP;

      v_json := v_json || '],';

      ------------------------------------------------------------------
      -- AVALIAÇÕES (subarray)
      ------------------------------------------------------------------
      v_json := v_json || '"avaliacoes":[';
      v_first_item := TRUE;

      FOR r_av IN (
        SELECT a.id_avaliacao, a.nota, a.comentario, a.cpf
        FROM avaliacao a
        WHERE a.cnpj = r_startup.cnpj
      ) LOOP
        IF NOT v_first_item THEN
          v_json := v_json || ',';
        ELSE
          v_first_item := FALSE;
        END IF;

        v_json := v_json || '{' ||
          '"id":' || r_av.id_avaliacao || ',' ||
          '"nota":' || NVL(r_av.nota, 0) || ',' ||
          '"comentario":"' || REPLACE(DBMS_LOB.SUBSTR(r_av.comentario,4000,1),'"','\"') || '",' ||
          '"cpf_usuario":"' || NVL(r_av.cpf, '') || '"' ||
        '}';
      END LOOP;

      v_json := v_json || ']}';
    END LOOP;

    v_json := v_json || ']';
    p_json := v_json;

  EXCEPTION
    WHEN OTHERS THEN
      p_json := '{"erro":"Erro ao gerar JSON: ' ||
                 REPLACE(SUBSTR(SQLERRM,1,800),'"','''') || '"}';
  END prc_exportar_todas_startups_json;

END pkg_exportacoes_startup;

