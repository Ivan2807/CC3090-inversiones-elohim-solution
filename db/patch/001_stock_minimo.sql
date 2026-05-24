-- Parche idempotente para bases existentes (sin recrear volumen Docker).
ALTER TABLE "Producto"
    ADD COLUMN IF NOT EXISTS stock_minimo INTEGER;

UPDATE "Producto"
SET stock_minimo = GREATEST(10, stock_actual + 5)
WHERE stock_minimo IS NULL;

ALTER TABLE "Producto"
    ALTER COLUMN stock_minimo SET DEFAULT 20;

ALTER TABLE "Producto"
    ALTER COLUMN stock_minimo SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'producto_stock_minimo_check'
    ) THEN
        ALTER TABLE "Producto"
            ADD CONSTRAINT producto_stock_minimo_check CHECK (stock_minimo >= 0);
    END IF;
END $$;
