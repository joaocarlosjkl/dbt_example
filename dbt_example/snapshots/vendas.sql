{% snapshot pedido_snapshot %}
    {{
        config(
            target_schema='historico',
            target_database='datawarehouse',
            unique_key='id_pedido',
            strategy='timestamp', -- usa uma coluna de data para detectar as mudanças
            --strategy='check', -- compara todas ou algumas colunas para fazer a mudança
            --check_cols = ['status', 'valor'], -- colunas que serão comparadas ou use all para todas as colunas
            updated_at='data_atualizacao'
        )
    }}

    SELECT 
        id_pedido,
        status,
        valor,
        data_atualizacao
    FROM pedidos

{% endsnapshot %}

-- o dbt cria as colunas de controle de versão automaticamente
    -- _dbt_valid_from
    -- _dbt_valid_to

-- comando para rodar o snapshot no dbt:
    -- dbt snapshot - s pedido_snapshot

