<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('atencion', function (Blueprint $table) {
            $table->timestamp('atnc_hora_real_inicio')->nullable()->after('atnc_hora_inicio');
        });
    }

    public function down(): void
    {
        Schema::table('atencion', function (Blueprint $table) {
            $table->dropColumn('atnc_hora_real_inicio');
        });
    }
};
