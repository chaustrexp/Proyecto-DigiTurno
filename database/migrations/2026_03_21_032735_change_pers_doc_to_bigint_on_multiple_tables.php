<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Eliminar llaves foráneas existentes (con try/catch por si los nombres de FK son diferentes en migrate:fresh)
        try { DB::statement('ALTER TABLE `asesor` DROP FOREIGN KEY `asesor_ibfk_1`'); } catch (\Exception $e) {}
        try { DB::statement('ALTER TABLE `coordinador` DROP FOREIGN KEY `coordinador_ibfk_1`'); } catch (\Exception $e) {}
        try { DB::statement('ALTER TABLE `solicitante` DROP FOREIGN KEY `solicitante_ibfk_1`'); } catch (\Exception $e) {}

        try { DB::statement('ALTER TABLE `asesor` DROP FOREIGN KEY `asesor_persona_pers_doc_foreign`'); } catch (\Exception $e) {}
        try { DB::statement('ALTER TABLE `coordinador` DROP FOREIGN KEY `coordinador_persona_pers_doc_foreign`'); } catch (\Exception $e) {}
        try { DB::statement('ALTER TABLE `solicitante` DROP FOREIGN KEY `solicitante_persona_pers_doc_foreign`'); } catch (\Exception $e) {}


        // 2. Cambiar tipos de datos a BIGINT UNSIGNED
        DB::statement('ALTER TABLE `persona` MODIFY `pers_doc` BIGINT UNSIGNED NOT NULL');
        DB::statement('ALTER TABLE `asesor` MODIFY `PERSONA_pers_doc` BIGINT UNSIGNED');
        DB::statement('ALTER TABLE `coordinador` MODIFY `PERSONA_pers_doc` BIGINT UNSIGNED');
        DB::statement('ALTER TABLE `solicitante` MODIFY `PERSONA_pers_doc` BIGINT UNSIGNED');

        // 3. Restaurar llaves foráneas
        DB::statement('ALTER TABLE `asesor` ADD CONSTRAINT `asesor_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
        DB::statement('ALTER TABLE `coordinador` ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
        DB::statement('ALTER TABLE `solicitante` ADD CONSTRAINT `solicitante_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('ALTER TABLE `asesor` DROP FOREIGN KEY `asesor_ibfk_1`');
        DB::statement('ALTER TABLE `coordinador` DROP FOREIGN KEY `coordinador_ibfk_1`');
        DB::statement('ALTER TABLE `solicitante` DROP FOREIGN KEY `solicitante_ibfk_1`');

        DB::statement('ALTER TABLE `persona` MODIFY `pers_doc` INT(11) NOT NULL');
        DB::statement('ALTER TABLE `asesor` MODIFY `PERSONA_pers_doc` INT(11)');
        DB::statement('ALTER TABLE `coordinador` MODIFY `PERSONA_pers_doc` INT(11)');
        DB::statement('ALTER TABLE `solicitante` MODIFY `PERSONA_pers_doc` INT(11)');

        DB::statement('ALTER TABLE `asesor` ADD CONSTRAINT `asesor_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
        DB::statement('ALTER TABLE `coordinador` ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
        DB::statement('ALTER TABLE `solicitante` ADD CONSTRAINT `solicitante_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`)');
    }
};
