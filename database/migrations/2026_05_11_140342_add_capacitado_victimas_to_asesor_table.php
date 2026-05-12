<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('asesor', function (Blueprint $table) {
            $table->boolean('ase_capacitado_victimas')->default(false)->after('ase_tipo_asesor');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('asesor', function (Blueprint $table) {
            $table->dropColumn('ase_capacitado_victimas');
        });
    }
};
