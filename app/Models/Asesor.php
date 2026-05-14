<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Asesor extends Model
{
    protected $table = 'asesor';
    protected $primaryKey = 'ase_id';
    public $timestamps = false;

    protected $fillable = [
        'ase_nrocontrato', 'ase_tipo_asesor', 'ase_sede', 'ase_capacitado_victimas', 'ase_genero', 'ase_vigencia', 'ase_password', 'ase_correo', 'PERSONA_pers_doc', 'ase_foto'
    ];

    public function persona()
    {
        return $this->belongsTo(Persona::class, 'PERSONA_pers_doc', 'pers_doc');
    }

    public function atenciones()
    {
        return $this->hasMany(Atencion::class, 'ASESOR_ase_id', 'ase_id');
    }

    public function pausas()
    {
        return $this->hasMany(PausaAsesor::class, 'ASESOR_ase_id', 'ase_id');
    }
}
