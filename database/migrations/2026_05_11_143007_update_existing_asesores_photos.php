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
        // Hombres
        $hombres = ['mauricio Puentes', 'Carlos Contreras'];
        foreach ($hombres as $nombre) {
            \DB::table('asesor')
                ->join('persona', 'asesor.PERSONA_pers_doc', '=', 'persona.pers_doc')
                ->whereRaw("CONCAT(persona.pers_nombres, ' ', persona.pers_apellidos) LIKE ?", ["%$nombre%"])
                ->update([
                    'ase_genero' => 'M',
                    'ase_foto'   => 'images/foto de perfil asesor.png'
                ]);
        }

        // Mujeres
        $mujeres = ['lorena perez', 'sara capacho', 'camila vera', 'sofia chaustre'];
        foreach ($mujeres as $nombre) {
            \DB::table('asesor')
                ->join('persona', 'asesor.PERSONA_pers_doc', '=', 'persona.pers_doc')
                ->whereRaw("CONCAT(persona.pers_nombres, ' ', persona.pers_apellidos) LIKE ?", ["%$nombre%"])
                ->update([
                    'ase_genero' => 'F',
                    'ase_foto'   => 'images/foto de perfil asesora.png'
                ]);
        }
        
        // Cualquier otro que tenga la foto vieja por defecto
        \DB::table('asesor')
            ->where('ase_foto', 'images/foto de perfil.jpg')
            ->update([
                'ase_foto' => 'images/foto de perfil asesor.png'
            ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // No revertible fácilmente sin saber los estados previos exactos
    }
};
